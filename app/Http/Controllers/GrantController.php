<?php

namespace App\Http\Controllers;

use App\Events\GrantApproved;
use App\Events\GrantDisbursed;
use App\Events\RepaymentCreated;
use App\Events\RepaymentUpdated;
use App\Events\TransactionUpdated;
use App\Helpers\GeneralHelper;
use App\Mail\RepaymentScheduleEmail;
use App\Models\Charge;
use App\Models\Client;
use App\Models\Collateral;
use App\Models\CustomField;
use App\Models\CustomFieldMeta;
use App\Models\Document;
use App\Models\GlJournalEntry;
use App\Models\GroupGrantAllocation;
use App\Models\Guarantor;
use App\Models\Grant;
use App\Models\GrantApplication;
use App\Models\GrantCharge;
use App\Models\GrantRepaymentSchedule;
use App\Models\GrantTransaction;
use App\Models\Note;
use App\Models\PaymentDetail;
use App\Models\Savings;
use App\Models\SavingsTransaction;
use App\Models\Setting;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use PDF;
use Cartalyst\Sentinel\Laravel\Facades\Sentinel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\View;
use Laracasts\Flash\Flash;

class GrantController extends Controller
{
    public function __construct()
    {
        $this->middleware('sentinel');
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!Sentinel::hasAccess('grants.view')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $data = Grant::where('status', 'disbursed')->get();

        return view('grant.data', compact('data'));
    }

    public function pending_approval()
    {
        if (!Sentinel::hasAccess('grants.pending_approval')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $data = Grant::where('status', 'pending')->get();

        return view('grant.pending_approval', compact('data'));
    }

    public function awaiting_disbursement()
    {
        if (!Sentinel::hasAccess('grants.awaiting_disbursement')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $data = Grant::where('status', 'approved')->get();

        return view('grant.awaiting_disbursement', compact('data'));
    }

    public function grants_declined()
    {
        if (!Sentinel::hasAccess('grants.declined')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $data = Grant::where('status', 'declined')->get();

        return view('grant.grants_declined', compact('data'));
    }


    public function grants_closed()
    {
        if (!Sentinel::hasAccess('grants.closed')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $data = Grant::where('status', 'closed')->get();

        return view('grant.grants_closed', compact('data'));
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!Sentinel::hasAccess('grants.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        return view('grant.create',
            compact(''));
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!Sentinel::hasAccess('grants.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'grant_officer_id' => 'required',
            'amount' => 'required',
            'client_id' => 'required',
        );
        $messages = [
            'grant_officer_id.required' => 'Grant Officer is required',
            'amount.required' => 'Amount is required',
            'client_id.required' => 'Client is required',
        ];
        $validator = Validator::make(Input::all(), $rules, $messages);
        if ($validator->fails()) {
            Flash::warning(trans('general.validation_error'));
            return redirect()->back()->withInput()->withErrors($validator);

        } else {
            $grant = new Grant();
            $grant->created_by_id = Sentinel::getUser()->id;
            $grant->created_date = $request->created_date;
            $grant->client_type = "client";
            $grant->client_id = $request->client_id;
            $grant->office_id =$request->office_id;
            $grant->grant_officer_id = $request->grant_officer_id;
            $grant->external_id = $request->external_id;
            $grant->amount = $request->amount;
            $grant->applied_amount = $request->amount;
            $grant->currency_id = $request->currency_id;
            $grant->decimals = $request->decimals;
            $grant->notes = $request->notes;
            $date = explode('-', $request->created_date);
            $grant->month = $date[1];
            $grant->year = $date[0];
            $grant->save();
            //check custom fields
            if (Setting::where('setting_key', 'enable_custom_fields')->first()->setting_value == 1) {
                $custom_fields = CustomField::where('category', 'grants')->get();
                foreach ($custom_fields as $key) {
                    $custom_field = new CustomFieldMeta();
                    $id = "custom_field_" . $key->id;
                    if ($key->field_type == "checkbox") {
                        if (!empty($request->$id)) {
                            $custom_field->name = serialize($request->$id);
                        } else {
                            $custom_field->name = serialize([]);
                        }
                    } else {
                        $custom_field->name = $request->$id;
                    }
                    $custom_field->parent_id = $grant->id;
                    $custom_field->custom_field_id = $key->id;
                    $custom_field->category = "grants";
                    $custom_field->save();
                }
            }
            GeneralHelper::audit_trail("Create", "Grants", $grant->id);
            Flash::success(trans('general.successfully_saved'));
            return redirect('grant/' . $grant->id . '/show');
        }
    }

    public function show($grant)
    {
        if (!Sentinel::hasAccess('grants.view')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        return view('grant.show', compact('grant', 'charges'));
    }


    public function edit($grant)
    {
        if (!Sentinel::hasAccess('grants.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return view('grant.edit',
            compact('grant'));

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'grant_officer_id' => 'required',
            'amount' => 'required',
        );
        $messages = [
            'grant_officer_id.required' => 'Grant Officer is required',
            'amount.required' => 'Amount is required',
            'client_id.required' => 'Client is required',
        ];
        $validator = Validator::make(Input::all(), $rules, $messages);
        if ($validator->fails()) {
            Flash::warning(trans('general.validation_error'));
            return redirect()->back()->withInput()->withErrors($validator);

        } else {
            $grant = Grant::find($id);
            $grant->created_date = $request->created_date;
            $grant->grant_officer_id = $request->grant_officer_id;
            $grant->external_id = $request->external_id;
            $grant->amount = $request->amount;
            $grant->applied_amount = $request->amount;
            $grant->currency_id = $request->currency_id;
            $grant->decimals = $request->decimals;
            $grant->notes = $request->notes;
            $date = explode('-', $request->created_date);
            $grant->month = $date[1];
            $grant->year = $date[0];
            $grant->save();
            if (Setting::where('setting_key', 'enable_custom_fields')->first()->setting_value == 1) {
                $custom_fields = CustomField::where('category', 'grants')->get();
                foreach ($custom_fields as $key) {
                    if (!empty(CustomFieldMeta::where('custom_field_id', $key->id)->where('parent_id', $id)->where('category',
                        'grants')->first())
                    ) {
                        $custom_field = CustomFieldMeta::where('custom_field_id', $key->id)->where('parent_id',
                            $id)->where('category', 'grants')->first();
                    } else {
                        $custom_field = new CustomFieldMeta();
                    }
                    $kid = "custom_field_" . $key->id;
                    if ($key->field_type == "checkbox") {
                        if (!empty($request->$kid)) {
                            $custom_field->name = serialize($request->$kid);
                        } else {
                            $custom_field->name = serialize([]);
                        }
                    } else {
                        $custom_field->name = $request->$kid;
                    }
                    $custom_field->parent_id = $id;
                    $custom_field->custom_field_id = $key->id;
                    $custom_field->category = "grants";
                    $custom_field->save();
                }
            }
            GeneralHelper::audit_trail("Update", "Grants", $grant->id);
            Flash::success(trans('general.successfully_saved'));
            return redirect('grant/' . $grant->id . '/show');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function delete($id)
    {
        if (!Sentinel::hasAccess('grants.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        Grant::destroy($id);
        GeneralHelper::audit_trail("Delete", "Grants", $id);
        Flash::success(trans('general.successfully_deleted'));
        return redirect('grant/data');
    }

    //client documents
    public function store_grant_document(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.documents.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'name' => 'required',
            'attachment' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $grant_document = new Document();
            $grant_document->record_id = $id;
            $grant_document->type = "grant";
            $grant_document->name = $request->name;
            $grant_document->notes = $request->notes;
            if ($request->hasFile('attachment')) {
                $file = array('attachment' => Input::file('attachment'));
                $rules = array('attachment' => 'required|mimes:jpeg,jpg,bmp,png,pdf,docx,doc,xlsx,pptx,xls');
                $validator = Validator::make($file, $rules);
                if ($validator->fails()) {
                    Flash::warning(trans('general.validation_error'));
                    return redirect()->back()->withInput()->withErrors($validator);
                } else {
                    $fname = str_slug($request->name, '_') . "" . uniqid() . '.' . $request->file('attachment')->guessExtension();
                    $grant_document->location = $fname;
                    $request->file('attachment')->move(public_path() . '/uploads',
                        $fname);
                }

            }
            $grant_document->save();
            GeneralHelper::audit_trail("Create Document", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function delete_grant_document(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.documents.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $grant_document = Document::find($id);
        if (!empty($grant_document->location)) {
            @unlink(public_path() . '/uploads/' . $grant_document->location);
        }
        Document::destroy($id);
        GeneralHelper::audit_trail("Delete Document", "Grants", $id);
        Flash::success(trans('general.successfully_deleted'));
        return redirect()->back();

    }

    //client notes
    public function store_note(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.notes.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'notes' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $note = new Note();
            $note->reference_id = $id;
            $note->created_by_id = Sentinel::getUser()->id;
            $note->type = "grant";
            $note->notes = $request->notes;
            $note->save();
            GeneralHelper::audit_trail("Create Note", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function delete_note(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.notes.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        Note::destroy($id);
        GeneralHelper::audit_trail("Delete Note", "Grants", $id);
        Flash::success(trans('general.successfully_deleted'));
        return redirect()->back();

    }

    public function show_note($note)
    {
        if (!Sentinel::hasAccess('grants.notes.view')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return View::make('grant.show_note', compact('note'))->render();

    }

    public function edit_note($note)
    {
        if (!Sentinel::hasAccess('grants.notes.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return View::make('grant.edit_note', compact('note'))->render();

    }

    public function update_note(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.notes.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        if (!Sentinel::hasAccess('grants.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'notes' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $note = Note::find($id);
            $note->notes = $request->notes;

            $note->save();
            GeneralHelper::audit_trail("Update Note", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    //grant collateral
    public function store_collateral(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.collateral.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'collateral_type_id' => 'required',
            'description' => 'required',
            'serial' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $collateral = new Collateral();
            $collateral->grant_id = $id;
            //$collateral->created_by_id = Sentinel::getUser()->id;
            $collateral->collateral_type_id = $request->collateral_type_id;
            $collateral->description = $request->description;
            $collateral->value = $request->value;
            $collateral->serial = $request->serial;
            $collateral->save();
            GeneralHelper::audit_trail("Create Collateral", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function delete_collateral(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.collateral.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        Collateral::destroy($id);
        GeneralHelper::audit_trail("Delete Collateral", "Grants", $id);
        Flash::success(trans('general.successfully_deleted'));
        return redirect()->back();

    }

    public function show_collateral($collateral)
    {
        if (!Sentinel::hasAccess('grants.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return View::make('grant.show_collateral', compact('collateral'))->render();

    }

    public function edit_collateral($collateral)
    {
        if (!Sentinel::hasAccess('grants.collateral.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return View::make('grant.edit_collateral', compact('collateral'))->render();

    }

    public function update_collateral(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.collateral.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'collateral_type_id' => 'required',
            'description' => 'required',
            'serial' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $collateral = Collateral::find($id);
            $collateral->collateral_type_id = $request->collateral_type_id;
            $collateral->description = $request->description;
            $collateral->value = $request->value;
            $collateral->serial = $request->serial;
            $collateral->save();
            GeneralHelper::audit_trail("Update Collateral", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    //grant collateral
    public function store_guarantor(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.guarantors.create')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'is_client' => 'required',
            'amount' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $guarantor = new Guarantor();
            $guarantor->grant_id = $id;
            //$collateral->created_by_id = Sentinel::getUser()->id;
            $guarantor->client_relationship_id = $request->client_relationship_id;
            $guarantor->is_client = $request->is_client;
            if ($request->client_id == 1) {
                $guarantor->client_id = $request->client_id;
                $guarantor->lock_funds = $request->lock_funds;
                $client = Client::find($request->client_id);
                $savings = Savings::where('client_id', $client->id)->first();
                if ($request->lock_funds == 1 && !empty($savings)) {
                    if (GeneralHelper::savings_account_balance($savings->id) < $request->amount) {
                        Flash::warning("Savings balance low");
                        return redirect()->back();
                    }
                    $savings_transaction = new SavingsTransaction();
                    $savings_transaction->created_by_id = Sentinel::getUser()->id;
                    $savings_transaction->office_id = $client->office_id;
                    $savings_transaction->savings_id = $savings->id;
                    $savings_transaction->transaction_type = "guarantee";
                    $savings_transaction->reversible = 1;
                    $savings_transaction->date = date("Y-m-d");
                    $savings_transaction->time = date("H:i");
                    $date = explode('-', date("Y-m-d"));
                    $savings_transaction->year = $date[0];
                    $savings_transaction->month = $date[1];
                    $savings_transaction->debit = $request->amount;
                    $savings_transaction->save();
                    $guarantor->savings_id = $savings->id;
                }
            } else {
                $guarantor->first_name = $request->first_name;
                $guarantor->middle_name = $request->middle_name;
                $guarantor->last_name = $request->last_name;
                $guarantor->mobile = $request->mobile;
            }

            $guarantor->amount = $request->amount;
            $guarantor->save();
            GeneralHelper::audit_trail("Create Guarantor", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function delete_guarantor(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.guarantors.delete')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $guarantor = Guarantor::find($id);
        Guarantor::destroy($id);
        foreach (SavingsTransaction::where('savings_id', $guarantor->savings_id)->where('transaction_type', 'guarantee')->get() as $key) {
            $savings_transaction = new SavingsTransaction();
            $savings_transaction->created_by_id = Sentinel::getUser()->id;
            $savings_transaction->office_id = $key->office_id;
            $savings_transaction->savings_id = $key->savings_id;
            $savings_transaction->transaction_type = "guarantee_restored";
            $savings_transaction->reversible = 1;
            $savings_transaction->date = date("Y-m-d");
            $savings_transaction->time = date("H:i");
            $date = explode('-', date("Y-m-d"));
            $savings_transaction->year = $date[0];
            $savings_transaction->month = $date[1];
            $savings_transaction->credit = $key->amount;
            $savings_transaction->save();

        }
        GeneralHelper::audit_trail("Delete Guarantor", "Grants", $id);
        Flash::success(trans('general.successfully_deleted'));
        return redirect()->back();

    }

    public function show_guarantor($guarantor)
    {
        if (!Sentinel::hasAccess('grants.guarantors.view')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return View::make('grant.show_guarantor', compact('guarantor'))->render();

    }

    public function edit_guarantor($guarantor)
    {
        if (!Sentinel::hasAccess('grants.guarantors.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        return View::make('grant.edit_guarantor', compact('guarantor'))->render();

    }

    public function update_guarantor(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.guarantors.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'amount' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $guarantor = Guarantor::find($id);
            $guarantor->amount = $request->amount;
            $guarantor->save();
            GeneralHelper::audit_trail("Update Guarantor", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function approve_grant(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.approve')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'approved_amount' => 'required',
            'approved_date' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $grant = Grant::find($id);
            if ($grant->status != "pending") {
                Flash::warning("Grant not pending");
                return redirect()->back();
            }
            $grant->status = "approved";
            $grant->approved_by_id = Sentinel::getUser()->id;
            $grant->approved_amount = $request->approved_amount;
            $grant->amount = $request->approved_amount;
            $grant->approved_date = $request->approved_date;
            $grant->approved_notes = $request->approved_notes;
            $grant->save();
            //event(new GrantApproved($grant));
            GeneralHelper::audit_trail("Approve", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function decline_grant(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.approve')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'declined_notes' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $grant = Grant::find($id);
            if ($grant->status != "pending") {
                Flash::warning("Grant not pending");
                return redirect()->back();
            }
            $grant->status = "declined";
            $grant->declined_by_id = Sentinel::getUser()->id;
            $grant->declined_date = date("Y-m-d");
            $grant->declined_notes = $request->declined_notes;
            $grant->save();
            GeneralHelper::audit_trail("Decline", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function change_grant_officer(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.update')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'grant_officer_id' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $grant = Grant::find($id);
            $grant->grant_officer_id = $request->grant_officer_id;
            $grant->save();
            GeneralHelper::audit_trail("Update", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function unapprove_grant(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.undo_approval')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        $grant = Grant::find($id);
        if ($grant->status != "approved") {
            Flash::warning("Grant not approved");
            return redirect()->back();
        }
        $grant->status = "pending";
        $grant->approved_by_id = null;
        $grant->approved_amount = null;
        $grant->approved_date = null;
        $grant->approved_notes = null;
        $grant->save();
        GeneralHelper::audit_trail("Unapprove", "Grants", $id);
        Flash::success(trans('general.successfully_saved'));
        return redirect()->back();
    }

    public function disburse_grant(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.disburse')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'disbursement_date' => 'required',
            'payment_type_id' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $grant = Grant::find($id);
            if ($grant->status != "approved") {
                Flash::warning("Grant not approved");
                return redirect()->back();
            }
            $payment_detail = new PaymentDetail();
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->receipt_number = $request->receipt_number;
            $payment_detail->bank = $request->bank;
            $payment_detail->notes = $request->notes;
            $payment_detail->save();
            $grant->status = "disbursed";
            $grant->disbursed_by_id = Sentinel::getUser()->id;
            $grant->payment_detail_id = $payment_detail->id;
            $grant->disbursed_notes = $request->disbursed_notes;
            $grant->disbursement_date = $request->disbursement_date;
            $grant->save();
            //event(new GrantDisbursed($grant));
            GeneralHelper::audit_trail("Disburse", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function undisburse_grant(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.undo_disbursement')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }

        $grant = Grant::find($id);
        if ($grant->status != "disbursed") {
            Flash::warning("Grant not disbursed");
            return redirect()->back();
        }
        $grant->status = "approved";
        $grant->disbursed_by_id = null;
        $grant->disbursed_notes = null;
        $grant->disbursement_date = null;
        $grant->save();
        //GlJournalEntry::where('grant_id', $grant->id)->delete();
        GeneralHelper::audit_trail("Undo Disburse", "Grants", $id);
        Flash::success(trans('general.successfully_saved'));
        return redirect()->back();
    }


    public function print_transaction($grant_transaction)
    {
        if (!Sentinel::hasAccess('grants.transactions.view')) {
            Flash::warning(trans('general.permission_denied'));
            return redirect()->back();
        }

        return view('grant.transaction.print', compact('grant_transaction'));
    }

    public function pdf_transaction($grant_transaction)
    {
        if (!Sentinel::hasAccess('grants.transactions.view')) {
            Flash::warning(trans('general.permission_denied'));
            return redirect()->back();
        }
        $pdf = PDF::loadView('grant.transaction.pdf', compact('grant_transaction'));
        return $pdf->download(trans_choice('general.grant', 1) . ' ' . trans_choice('general.transaction', 1) . ' ' . trans_choice('general.receipt', 1) . ".pdf");

    }

    public function withdraw_grant(Request $request, $id)
    {
        if (!Sentinel::hasAccess('grants.approve')) {
            Flash::warning("Permission Denied");
            return redirect()->back();
        }
        $rules = array(
            'withdrawn_notes' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            $grant = Grant::find($id);
            if ($grant->status != "pending") {
                Flash::warning("Grant not pending");
                return redirect()->back();
            }
            $grant->status = "withdrawn";
            $grant->withdrawn_by_id = Sentinel::getUser()->id;
            $grant->withdrawn_date = date("Y-m-d");
            $grant->withdrawn_notes = $request->withdrawn_notes;
            $grant->save();
            GeneralHelper::audit_trail("Withdraw", "Grants", $id);
            Flash::success(trans('general.successfully_saved'));
            return redirect()->back();
        }
    }

    public function email_schedule($grant)
    {
        if (!Sentinel::hasAccess('grants.email_schedule')) {
            Flash::warning(trans('general.permission_denied'));
            return redirect()->back();
        }
        $email = "";
        if ($grant->client_type == "client") {
            $email = $grant->client->email;
        }
        if ($grant->client_type == "group") {
            $email = $grant->group->email;
        }
        if (!empty($email)) {
            Mail::to($email)->send(new RepaymentScheduleEmail($grant));
        } else {
            Flash::warning("Client has no email");
        }

        Flash::success(trans('general.successfully_saved'));
        return redirect()->back();
    }


}

@extends('layouts.master')
@section('title')
    {{ trans_choice('general.grant',1) }} {{ trans_choice('general.detail',2) }}
@endsection
@section('content')
    <div class="row">
        <div class="col-md-12">
            <div class="panel ">
                <div class="panel-heading">
                    <h6 class="panel-title">#{{$grant->id}}</h6>

                    <div class="heading-elements">

                    </div>
                </div>
                <div class="panel-body">
                    @if($grant->status=="pending")
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pull-right btn-group">
                                    @if(Sentinel::hasAccess('grants.approve'))
                                        <a href="#" data-toggle="modal" data-target="#approve_grant_modal"
                                           class="btn btn-primary"><i
                                                    class="fa fa-check"></i>&nbsp;{{trans_choice('general.approve',1)}}
                                        </a>
                                        <a href="#" data-toggle="modal" data-target="#decline_grant_modal"
                                           class="btn btn-primary"><i
                                                    class="fa fa-times"></i>&nbsp;{{trans_choice('general.decline',1)}}
                                        </a>
                                    @endif
                                    @if(Sentinel::hasAccess('grants.update'))
                                        <a href="{{ url('grant/'.$grant->id.'/edit') }}" class="btn btn-primary"><i
                                                    class="fa fa-edit"></i>&nbsp;{{trans_choice('general.edit',1)}}</a>
                                    @endif
                                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"
                                            aria-expanded="false">More<span class="caret"></span></button>
                                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                                        @if(Sentinel::hasAccess('grants.update'))
                                            <li>
                                                <a href="#"
                                                   data-toggle="modal" data-target="#change_grant_officer_modal">
                                                    {{ trans_choice('general.change',1) }} {{ trans_choice('general.grant',1) }} {{ trans_choice('general.officer',1) }}</a>
                                            </li>
                                        @endif
                                        @if(Sentinel::hasAccess('grants.approve'))
                                            <li>
                                                <a href="#"
                                                   data-toggle="modal" data-target="#withdraw_grant_modal">
                                                    {{ trans('general.withdraw') }}</a>
                                            </li>
                                        @endif
                                        @if(Sentinel::hasAccess('grants.delete'))
                                            <li>
                                                <a href="{{ url('grant/'.$grant->id.'/delete') }}"
                                                   class="delete">
                                                    {{ trans('general.delete') }}</a>
                                            </li>
                                        @endif
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row m-t-20" style="">
                            <div class="col-sm-7 col-md-7">
                                <table class="table table-striped table-bordered">
                                    <tbody>
                                    @if($grant->client_type=="client")
                                        <tr>
                                            <th class="table-bold-grant">{{trans_choice('general.client',1)}}</th>
                                            <td>
                                        <span class="padded-td">
                                             @if(!empty($grant->client))
                                                @if($grant->client->client_type=="individual")
                                                    <a href="{{url('client/'.$grant->client_id.'/show')}}">{{$grant->client->first_name}} {{$grant->client->middle_name}} {{$grant->client->last_name}}</a>
                                                    ({{trans_choice('general.individual',1)}})
                                                @else
                                                    <a href="{{url('client/'.$grant->client_id.'/show')}}">{{$grant->client->full_name}}</a>
                                                    ({{trans_choice('general.business',1)}})
                                                @endif
                                            @endif
                                        </span>
                                            </td>
                                        </tr>
                                    @endif
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.currency',1)}}</th>
                                        <td>
                                        <span class="padded-td">
                                              @if(!empty($grant->currency))
                                                {{$grant->currency->name}}
                                            @endif
                                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.grant',1)}} {{trans_choice('general.officer',1)}}</th>
                                        <td>
                                        <span class="padded-td">
                                              @if(!empty($grant->grant_officer))
                                                {{$grant->grant_officer->first_name}} {{$grant->grant_officer->last_name}}
                                            @endif
                                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.external_id',1)}} </th>
                                        <td>
                                            <span class="padded-td">{{ $grant->external_id }}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-5 col-md-5">
                                <table class="table table-striped table-bordered">
                                    <tbody>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.proposed',1)}} {{trans_choice('general.amount',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ number_format($grant->amount,$grant->decimals) }}</span>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>

                            </div>
                        </div>
                        @if(Sentinel::hasAccess('grants.approve'))
                            <div class="modal fade" id="approve_grant_modal">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">{{trans_choice('general.approve',1)}} {{trans_choice('general.grant',1)}}</h4>
                                        </div>
                                        <form method="post" action="{{url('grant/'.$grant->id.'/approve')}}"
                                              class="form-horizontal "
                                              enctype="multipart/form-data" id="approve_grant_form">
                                            {{csrf_field()}}
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="approved_date"
                                                           class="control-label col-md-3">{{trans_choice('general.approved',1)}} {{trans_choice('general.date',1)}}</label>
                                                    <div class="col-md-9">
                                                        <input type="text" name="approved_date"
                                                               class="form-control date-picker"
                                                               value="{{date("Y-m-d")}}"
                                                               required id="approved_date">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="approved_amount"
                                                           class="control-label col-md-3">{{trans_choice('general.amount',1)}}</label>
                                                    <div class="col-md-9">
                                                        <input type="number" name="approved_amount" class="form-control"
                                                               value="{{$grant->applied_amount}}"
                                                               required id="approved_amount">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="approved_notes"
                                                           class="control-label col-md-3">{{trans_choice('general.note',2)}}</label>
                                                    <div class="col-md-9">
                                                     <textarea name="approved_notes" class="form-control"
                                                               id="approved_notes"
                                                               rows="3">{{old('approved_notes')}}</textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default pull-left"
                                                        data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                                                <button type="submit"
                                                        class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="decline_grant_modal">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">{{trans_choice('general.decline',1)}} {{trans_choice('general.grant',1)}}</h4>
                                        </div>
                                        <form method="post" action="{{url('grant/'.$grant->id.'/decline')}}"
                                              class="form-horizontal "
                                              enctype="multipart/form-data" id="decline_grant_form">
                                            {{csrf_field()}}
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="declined_notes"
                                                           class="control-label col-md-3">{{trans_choice('general.note',2)}}</label>
                                                    <div class="col-md-9">
                                                     <textarea name="declined_notes" class="form-control"
                                                               id="declined_notes" rows="3"
                                                               required>{{old('declined_notes')}}</textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default pull-left"
                                                        data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                                                <button type="submit"
                                                        class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        @endif
                        <div class="modal fade" id="withdraw_grant_modal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">{{trans_choice('general.withdraw',1)}} {{trans_choice('general.grant',1)}}</h4>
                                    </div>
                                    <form method="post" action="{{url('grant/'.$grant->id.'/withdraw')}}"
                                          class="form-horizontal "
                                          enctype="multipart/form-data" id="withdraw_grant_form">
                                        {{csrf_field()}}
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="withdrawn_notes"
                                                       class="control-label col-md-3">{{trans_choice('general.note',2)}}</label>
                                                <div class="col-md-9">
                                                     <textarea name="withdrawn_notes" class="form-control"
                                                               id="declined_notes" rows="3"
                                                               required>{{old('withdrawn_notes')}}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default pull-left"
                                                    data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                                            <button type="submit"
                                                    class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    @endif
                    @if($grant->status=="approved")
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pull-right btn-group">
                                    @if(Sentinel::hasAccess('grants.disburse'))
                                        <a href="#" data-toggle="modal" data-target="#disburse_grant_modal"
                                           class="btn btn-primary"><i
                                                    class="fa fa-flag"></i>&nbsp;{{trans_choice('general.disburse',1)}}
                                        </a>
                                    @endif
                                    @if(Sentinel::hasAccess('grants.undo_approval'))
                                        <a href="{{ url('grant/'.$grant->id.'/unapprove') }}"
                                           class="btn btn-primary confirm"><i
                                                    class="fa fa-undo"></i>&nbsp;{{trans_choice('general.undo',1)}}
                                            &nbsp;{{trans_choice('general.approval',1)}}</a>
                                    @endif
                                    @if(Sentinel::hasAccess('grants.update'))
                                        <a href="#"
                                           data-toggle="modal" data-target="#change_grant_officer_modal"
                                           class="btn btn-primary"><i
                                                    class="fa fa-user"></i>&nbsp;
                                            {{ trans_choice('general.change',1) }} {{ trans_choice('general.grant',1) }} {{ trans_choice('general.officer',1) }}
                                        </a>
                                    @endif
                                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"
                                            aria-expanded="false">More<span class="caret"></span></button>

                                </div>
                            </div>
                        </div>
                        <div class="row m-t-20" style="">
                            <div class="col-sm-7 col-md-7">
                                <table class="table table-striped table-bordered">
                                    <tbody>
                                    @if($grant->client_type=="client")
                                        <tr>
                                            <th class="table-bold-grant">{{trans_choice('general.client',1)}}</th>
                                            <td>
                                        <span class="padded-td">
                                             @if(!empty($grant->client))
                                                @if($grant->client->client_type=="individual")
                                                    <a href="{{url('client/'.$grant->client_id.'/show')}}">{{$grant->client->first_name}} {{$grant->client->middle_name}} {{$grant->client->last_name}}</a>
                                                    ({{trans_choice('general.individual',1)}})
                                                @else
                                                    <a href="{{url('client/'.$grant->client_id.'/show')}}">{{$grant->client->full_name}}</a>
                                                    ({{trans_choice('general.business',1)}})
                                                @endif
                                            @endif
                                        </span>
                                            </td>
                                        </tr>
                                    @endif
                                    @if($grant->client_type=="group")
                                        <tr>
                                            <th class="table-bold-grant">{{trans_choice('general.group',1)}}</th>
                                            <td>
                                        <span class="padded-td">
                                             @if(!empty($grant->group))
                                                <a href="{{url('group/'.$grant->group_id.'/show')}}">{{$grant->group->name}}</a>
                                            @endif
                                        </span>
                                            </td>
                                        </tr>
                                    @endif
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.currency',1)}}</th>
                                        <td>
                                        <span class="padded-td">
                                              @if(!empty($grant->currency))
                                                {{$grant->currency->name}}
                                            @endif
                                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.grant',1)}} {{trans_choice('general.officer',1)}}</th>
                                        <td>
                                        <span class="padded-td">
                                              @if(!empty($grant->grant_officer))
                                                {{$grant->grant_officer->first_name}} {{$grant->grant_officer->last_name}}
                                            @endif
                                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.external_id',1)}} </th>
                                        <td>
                                            <span class="padded-td">{{ $grant->external_id }}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-5 col-md-5">
                                <table class="table table-striped table-bordered">
                                    <tbody>

                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.proposed',1)}} {{trans_choice('general.amount',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ number_format($grant->applied_amount,$grant->decimals) }}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.approved',1)}} {{trans_choice('general.amount',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ number_format($grant->approved_amount,$grant->decimals) }}</span>
                                        </td>
                                    </tr>
                                    <tr class="hidden">
                                        <th class="table-bold-grant">{{trans_choice('general.expected',1)}} {{trans_choice('general.disbursement',1)}} {{trans_choice('general.date',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ $grant->expected_disbursement_date }}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                        <div class="modal fade" id="disburse_grant_modal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">{{trans_choice('general.disburse',1)}} {{trans_choice('general.grant',1)}}</h4>
                                    </div>
                                    <form method="post" action="{{url('grant/'.$grant->id.'/disburse')}}"
                                          class="form-horizontal "
                                          enctype="multipart/form-data" id="disburse_grant_form">
                                        {{csrf_field()}}
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="disbursement_date"
                                                       class="control-label col-md-4">{{trans_choice('general.disbursement',1)}} {{trans_choice('general.date',1)}}</label>
                                                <div class="col-md-8">
                                                    <input type="text" name="disbursement_date"
                                                           class="form-control date-picker"
                                                           value="{{$grant->expected_disbursement_date}}"
                                                           required id="disbursement_date">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="payment_type_id"
                                                       class="control-label col-md-4">{{trans_choice('general.payment',1)}} {{trans_choice('general.type',1)}}
                                                </label>
                                                <div class="col-md-8">
                                                    <select name="payment_type_id" class="form-control select2"
                                                            id="payment_type_id" required>
                                                        <option></option>
                                                        @foreach(\App\Models\PaymentType::all() as $key)
                                                            <option value="{{$key->id}}">{{$key->name}}</option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="approved_amount"
                                                       class="control-label col-md-4">{{trans_choice('general.show',1)}} {{trans_choice('general.payment',1)}} {{trans_choice('general.detail',2)}}</label>
                                                <div class="col-md-8">
                                                    <button type="button" class="btn btn-primary" data-toggle="collapse"
                                                            data-target="#show_payment_details">
                                                        <i class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div id="show_payment_details" class="collapse">
                                                <div class="form-group">
                                                    <label for="account_number"
                                                           class="control-label col-md-4">{{trans_choice('general.account',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="account_number"
                                                               class="form-control"
                                                               value=""
                                                               id="account_number">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="cheque_number"
                                                           class="control-label col-md-4">{{trans_choice('general.cheque',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="cheque_number"
                                                               class="form-control"
                                                               value=""
                                                               id="cheque_number">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="routing_code"
                                                           class="control-label col-md-4">{{trans_choice('general.routing_code',1)}}</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="routing_code"
                                                               class="form-control"
                                                               value=""
                                                               id="routing_code">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="receipt_number"
                                                           class="control-label col-md-4">{{trans_choice('general.receipt',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="receipt_number"
                                                               class="form-control"
                                                               value=""
                                                               id="receipt_number">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="bank"
                                                           class="control-label col-md-4">{{trans_choice('general.bank',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="bank"
                                                               class="form-control"
                                                               value=""
                                                               id="bank">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="disbursed_notes"
                                                       class="control-label col-md-4">{{trans_choice('general.note',2)}}</label>
                                                <div class="col-md-8">
                                                     <textarea name="disbursed_notes" class="form-control"
                                                               id="disbursed_notes"
                                                               rows="3">{{old('disbursed_notes')}}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default pull-left"
                                                    data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                                            <button type="submit"
                                                    class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    @endif
                    @if($grant->status=="disbursed")
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pull-right btn-group">
                                    @if(Sentinel::hasAccess('grants.update'))
                                        <a href="#"
                                           data-toggle="modal" data-target="#change_grant_officer_modal"
                                           class="btn btn-primary"><i
                                                    class="fa fa-user"></i>&nbsp;
                                            {{ trans_choice('general.change',1) }} {{ trans_choice('general.grant',1) }} {{ trans_choice('general.officer',1) }}
                                        </a>
                                    @endif
                                    @if(Sentinel::hasAccess('grants.undo_disbursement'))
                                        <a href="{{ url('grant/'.$grant->id.'/undisburse') }}"
                                           class="btn btn-primary confirm"><i
                                                    class="fa fa-undo"></i>&nbsp;{{trans_choice('general.undo',1)}}
                                            &nbsp;{{trans_choice('general.disbursement',1)}}</a>
                                    @endif
                                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"
                                            aria-expanded="false">More <span class="caret"></span></button>
                                    <ul class="dropdown-menu dropdown-menu-right" role="menu">

                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row m-t-20" style="">
                            <div class="col-sm-8 col-md-8">
                                <table class="table table-striped table-bordered">
                                    <tbody>
                                    @if($grant->client_type=="client")
                                        <tr>
                                            <th class="table-bold-grant">{{trans_choice('general.client',1)}}</th>
                                            <td>
                                        <span class="padded-td">
                                             @if(!empty($grant->client))
                                                @if($grant->client->client_type=="individual")
                                                    <a href="{{url('client/'.$grant->client_id.'/show')}}">{{$grant->client->first_name}} {{$grant->client->middle_name}} {{$grant->client->last_name}}</a>
                                                    ({{trans_choice('general.individual',1)}})
                                                @else
                                                    <a href="{{url('client/'.$grant->client_id.'/show')}}">{{$grant->client->full_name}}</a>
                                                    ({{trans_choice('general.business',1)}})
                                                @endif
                                            @endif
                                        </span>
                                            </td>
                                        </tr>
                                    @endif
                                    @if($grant->client_type=="group")
                                        <tr>
                                            <th class="table-bold-grant">{{trans_choice('general.group',1)}}</th>
                                            <td>
                                        <span class="padded-td">
                                             @if(!empty($grant->group))
                                                <a href="{{url('group/'.$grant->group_id.'/show')}}">{{$grant->group->name}}</a>
                                            @endif
                                        </span>
                                            </td>
                                        </tr>
                                    @endif
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.currency',1)}}</th>
                                        <td>
                                        <span class="padded-td">
                                              @if(!empty($grant->currency))
                                                {{$grant->currency->name}}
                                            @endif
                                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.grant',1)}} {{trans_choice('general.officer',1)}}</th>
                                        <td>
                                        <span class="padded-td">
                                              @if(!empty($grant->grant_officer))
                                                {{$grant->grant_officer->first_name}} {{$grant->grant_officer->last_name}}
                                            @endif
                                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.external_id',1)}} </th>
                                        <td>
                                            <span class="padded-td">{{ $grant->external_id }}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <table class="table table-striped table-bordered">
                                    <tbody>

                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.proposed',1)}} {{trans_choice('general.amount',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ number_format($grant->applied_amount,$grant->decimals) }}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.approved',1)}} {{trans_choice('general.amount',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ number_format($grant->approved_amount,$grant->decimals) }}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant"> {{trans_choice('general.disbursed',1)}} {{trans_choice('general.amount',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ number_format($grant->amount,$grant->decimals) }}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-bold-grant">{{trans_choice('general.disbursement',1)}} {{trans_choice('general.date',1)}}</th>
                                        <td>
                                            <span class="padded-td">{{ $grant->disbursement_date }}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                        <div class="modal fade" id="disburse_grant_modal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">{{trans_choice('general.disburse',1)}} {{trans_choice('general.grant',1)}}</h4>
                                    </div>
                                    <form method="post" action="{{url('grant/'.$grant->id.'/disburse')}}"
                                          class="form-horizontal "
                                          enctype="multipart/form-data" id="disburse_grant_form">
                                        {{csrf_field()}}
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="disbursement_date"
                                                       class="control-label col-md-4">{{trans_choice('general.disbursement',1)}} {{trans_choice('general.date',1)}}</label>
                                                <div class="col-md-8">
                                                    <input type="text" name="disbursement_date"
                                                           class="form-control date-picker"
                                                           value="{{$grant->expected_disbursement_date}}"
                                                           required id="disbursement_date">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="first_repayment_date"
                                                       class="control-label col-md-4">{{trans_choice('general.first',1)}} {{trans_choice('general.repayment',1)}} {{trans_choice('general.date',1)}}</label>
                                                <div class="col-md-8">
                                                    <input type="text" name="first_repayment_date"
                                                           class="form-control date-picker"
                                                           value="{{$grant->expected_first_repayment_date}}"
                                                           required id="first_repayment_date">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="payment_type_id"
                                                       class="control-label col-md-4">{{trans_choice('general.payment',1)}} {{trans_choice('general.type',1)}}
                                                </label>
                                                <div class="col-md-8">
                                                    <select name="payment_type_id" class="form-control select2"
                                                            id="payment_type_id" required>
                                                        <option></option>
                                                        @foreach(\App\Models\PaymentType::all() as $key)
                                                            <option value="{{$key->id}}">{{$key->name}}</option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="approved_amount"
                                                       class="control-label col-md-4">{{trans_choice('general.show',1)}} {{trans_choice('general.payment',1)}} {{trans_choice('general.detail',2)}}</label>
                                                <div class="col-md-8">
                                                    <button type="button" class="btn btn-primary" data-toggle="collapse"
                                                            data-target="#show_payment_details">
                                                        <i class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div id="show_payment_details" class="collapse">
                                                <div class="form-group">
                                                    <label for="account_number"
                                                           class="control-label col-md-4">{{trans_choice('general.account',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="account_number"
                                                               class="form-control"
                                                               value=""
                                                               id="account_number">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="cheque_number"
                                                           class="control-label col-md-4">{{trans_choice('general.cheque',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="cheque_number"
                                                               class="form-control"
                                                               value=""
                                                               id="cheque_number">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="routing_code"
                                                           class="control-label col-md-4">{{trans_choice('general.routing_code',1)}}</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="routing_code"
                                                               class="form-control"
                                                               value=""
                                                               id="routing_code">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="receipt_number"
                                                           class="control-label col-md-4">{{trans_choice('general.receipt',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="receipt_number"
                                                               class="form-control"
                                                               value=""
                                                               id="receipt_number">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="bank"
                                                           class="control-label col-md-4">{{trans_choice('general.bank',1)}}
                                                        #</label>
                                                    <div class="col-md-8">
                                                        <input type="text" name="bank"
                                                               class="form-control"
                                                               value=""
                                                               id="bank">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="disbursed_notes"
                                                       class="control-label col-md-4">{{trans_choice('general.note',2)}}</label>
                                                <div class="col-md-8">
                                                     <textarea name="disbursed_notes" class="form-control"
                                                               id="disbursed_notes"
                                                               rows="3">{{old('disbursed_notes')}}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default pull-left"
                                                    data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                                            <button type="submit"
                                                    class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    @endif
                    @if($grant->status=="withdrawn")
                        <div class="row">
                            <div class="col-md-12">
                                <blockquote>
                                    <p>{{$grant->withdrawn_notes}}</p>
                                    <small>{{$grant->withdrawn_date}}</small>
                                </blockquote>
                            </div>
                        </div>
                    @endif
                    @if($grant->status=="declined")
                        <div class="row">
                            <div class="col-md-12">
                                <blockquote>
                                    <p>{{$grant->declined_notes}}</p>
                                    <small>{{$grant->declined_date}}</small>
                                </blockquote>
                            </div>
                        </div>
                    @endif
                    @if($grant->status=="written_off")
                        <div class="row">
                            <div class="col-md-12">
                                <blockquote>
                                    <p>{{$grant->written_off_notes}}</p>
                                    <small>{{$grant->written_off_date}}</small>
                                </blockquote>
                            </div>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    @if(Sentinel::hasAccess('grants.view'))
                        <li class="active"><a href="#account_details" data-toggle="tab"
                                              aria-expanded="false">{{trans_choice('general.account',1)}} {{trans_choice('general.detail',2)}}</a>
                        </li>
                    @endif
                    @if(Sentinel::hasAccess('grants.documents.view'))
                        <li class=""><a href="#documents" data-toggle="tab"
                                        aria-expanded="false">{{trans_choice('general.document',2)}}</a>
                        </li>
                    @endif
                    @if(Sentinel::hasAccess('grants.notes.view'))
                        <li class=""><a href="#notes" data-toggle="tab"
                                        aria-expanded="false">{{trans_choice('general.note',2)}}</a>
                        </li>
                    @endif
                    @if($grant->client_type=="group")
                        <li class=""><a href="#group_allocation" data-toggle="tab"
                                        aria-expanded="false">{{trans_choice('general.group',1)}} {{trans_choice('general.allocation',1)}}</a>
                        </li>
                    @endif
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="account_details">
                        <table class="table table-striped table-hover">
                            <tr>
                                <td>{{trans_choice('general.amount',1)}}</td>
                                <td>
                                    {{number_format($grant->amount,$grant->decimals)}}
                                </td>
                            </tr>
                            @if($grant->status=="disbursed")
                                @if(!empty($grant->payment_detail))
                                    @if(!empty($grant->payment_detail->type))
                                        <tr>
                                            <td>{{trans_choice('general.payment',1)}} {{trans_choice('general.type',1)}}</td>
                                            <td>
                                                {{$grant->payment_detail->type->name}}
                                            </td>
                                        </tr>
                                    @endif
                                    @if(!empty($grant->payment_detail->account_number))
                                        <tr>
                                            <td>{{trans_choice('general.account',1)}}#</td>
                                            <td>
                                                {{$grant->payment_detail->account_number}}
                                            </td>
                                        </tr>
                                    @endif
                                    @if(!empty($grant->payment_detail->cheque_number))
                                        <tr>
                                            <td>{{trans_choice('general.cheque',1)}}#</td>
                                            <td>
                                                {{$grant->payment_detail->cheque_number}}
                                            </td>
                                        </tr>
                                    @endif
                                    @if(!empty($grant->payment_detail->routing_code))
                                        <tr>
                                            <td>{{trans_choice('general.routing_code',1)}}#</td>
                                            <td>
                                                {{$grant->payment_detail->routing_code}}
                                            </td>
                                        </tr>
                                    @endif
                                    @if(!empty($grant->payment_detail->receipt_number))
                                        <tr>
                                            <td>{{trans_choice('general.receipt',1)}}#</td>
                                            <td>
                                                {{$grant->payment_detail->receipt_number}}
                                            </td>
                                        </tr>
                                    @endif
                                    @if(!empty($grant->payment_detail->bank))
                                        <tr>
                                            <td>{{trans_choice('general.bank',1)}}#</td>
                                            <td>
                                                {{$grant->payment_detail->bank}}
                                            </td>
                                        </tr>
                                    @endif
                                @endif
                            @endif
                            <tr>
                                <td>{{trans_choice('general.note',2)}}</td>
                                <td>
                                    {{$grant->notes}}
                                </td>
                            </tr>

                            @foreach(\App\Models\CustomFieldMeta::where('category', 'grants')->where('parent_id', $grant->id)->get() as $key)
                                <tr>
                                    <td>
                                        @if(!empty($key->custom_field))
                                            {{$key->custom_field->name}}
                                        @endif
                                    </td>
                                    <td>
                                        @if($key->custom_field->field_type=="checkbox")
                                            @foreach(unserialize($key->name) as $v=>$k)
                                                {{$k}}<br>
                                            @endforeach
                                        @else
                                            {{$key->name}}
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                            <tr>
                                <td>{{trans_choice('general.submitted',1)}} {{trans_choice('general.on',1)}}</td>
                                <td>
                                    {{$grant->created_date}}
                                    @if(!empty($grant->created_by))
                                        by {{$grant->created_by->first_name}} {{$grant->created_by->last_name}}
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <td>{{trans_choice('general.approved',1)}} {{trans_choice('general.on',1)}}</td>
                                <td>
                                    {{$grant->approved_date}}
                                    @if(!empty($grant->approved_by))
                                        by {{$grant->approved_by->first_name}} {{$grant->approved_by->last_name}}
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <td>{{trans_choice('general.disbursed',1)}} {{trans_choice('general.on',1)}}</td>
                                <td>
                                    {{$grant->disbursed_date}}
                                    @if(!empty($grant->disbursed_by))
                                        by {{$grant->disbursed_by->first_name}} {{$grant->disbursed_by->last_name}}
                                    @endif
                                </td>
                            </tr>
                        </table>
                    </div>
                    @if(Sentinel::hasAccess('grants.documents.view'))
                        <div class="tab-pane" id="documents">
                            <div class="row">
                                <div class="col-md-12">
                                    @if(Sentinel::hasAccess('grants.documents.create'))
                                        <a href="#add_document_modal"
                                           data-toggle="modal" class="btn btn-info pull-right"><i
                                                    class="fa fa-plus"></i> {{trans_choice('general.add',1)}} {{trans_choice('general.document',1)}}
                                        </a>
                                    @endif
                                </div>
                                <div class="col-md-12 table-responsive">
                                    <table class="table table-hover table-striped" id="">
                                        <thead>
                                        <tr>
                                            <th>{{ trans_choice('general.name',1) }}</th>
                                            <th>{{ trans('general.description') }}</th>
                                            <th>{{ trans_choice('general.action',1) }}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @foreach(\App\Models\Document::where('record_id',$grant->id)->where('type','grant')->get() as $key)
                                            <tr>
                                                <td>{{ $key->name }}</td>
                                                <td>{!!   $key->notes !!}</td>
                                                <td>
                                                    <a class="" href="{{asset('uploads/'.$key->location)}}"
                                                       target="_blank"><i class="fa fa-download"></i> </a>
                                                    @if(Sentinel::hasAccess('grants.documents.delete'))
                                                        <a class="confirm"
                                                           href="{{url('grant/document/'.$key->id.'/delete')}}"><i
                                                                    class="fa fa-trash"></i> </a>
                                                    @endif
                                                </td>
                                            </tr>
                                        @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    @endif

                    @if(Sentinel::hasAccess('grants.guarantors.view'))
                        <div class="tab-pane" id="guarantors">
                            <div class="row">
                                <div class="col-md-12">
                                    @if(Sentinel::hasAccess('grants.guarantors.create'))
                                        <a href="#add_guarantor_modal"
                                           data-toggle="modal" class="btn btn-info pull-right"><i
                                                    class="fa fa-plus"></i> {{trans_choice('general.add',1)}} {{trans_choice('general.guarantor',1)}}
                                        </a>
                                    @endif
                                </div>
                                <div class="col-md-12 table-responsive">
                                    <table id="" class="table table-striped table-condensed table-hover">
                                        <thead>
                                        <tr>
                                            <th>{{trans_choice('general.name',1)}}</th>
                                            <th>{{trans_choice('general.relationship',1)}}</th>
                                            <th>{{trans_choice('general.type',1)}}</th>
                                            <th>{{trans_choice('general.amount',1)}}</th>
                                            <th>{{trans_choice('general.mobile',1)}}</th>
                                            <th>{{ trans_choice('general.action',1) }}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @foreach($grant->guarantors as $key)
                                            <tr>
                                                <td>
                                                    @if($key->is_client==1)
                                                        @if(!empty($key->client))
                                                            <a href="{{url('client/'.$key->client_id.'/show')}}">{{ $key->client->first_name }} {{ $key->client->midddle_name }} {{ $key->client->last_name }}</a>
                                                        @endif
                                                    @else
                                                        {{ $key->first_name }} {{ $key->midddle_name }} {{ $key->last_name }}
                                                    @endif
                                                </td>
                                                <td>
                                                    @if(!empty($key->relationship))
                                                        {{$key->relationship->name}}
                                                    @endif
                                                </td>
                                                <td>
                                                    @if($key->is_client==1)
                                                        {{trans_choice('general.client',1)}}
                                                    @else
                                                        {{trans_choice('general.external',1)}}
                                                    @endif
                                                </td>
                                                <td>{{ $key->amount }}</td>
                                                <td>
                                                    @if($key->is_client==1)
                                                        @if(!empty($key->client))
                                                            {{$key->client->mobile}}
                                                        @endif
                                                    @else
                                                        {{ $key->mobile }}
                                                    @endif


                                                </td>
                                                <td>
                                                    @if($key->is_client==1)
                                                        <a href="{{url('client/'.$key->client_id.'/show')}}"><i
                                                                    class="fa fa-eye"></i> </a>
                                                    @else
                                                        <a data-id="{{$key->id}}" href="#" data-toggle="modal"
                                                           data-target="#view_guarantor"><i class="fa fa-eye"></i> </a>
                                                    @endif
                                                    @if(Sentinel::hasAccess('grants.guarantors.update'))
                                                        <a data-id="{{$key->id}}" href="#" data-toggle="modal"
                                                           data-target="#edit_guarantor"><i class="fa fa-edit"></i> </a>
                                                    @endif
                                                    @if(Sentinel::hasAccess('grants.guarantors.delete'))
                                                        <a class="confirm"
                                                           href="{{url('grant/guarantor/'.$key->id.'/delete')}}"><i
                                                                    class="fa fa-trash"></i> </a>
                                                    @endif
                                                </td>
                                            </tr>
                                        @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    @endif
                    @if(Sentinel::hasAccess('grants.notes.view'))
                        <div class="tab-pane" id="notes">
                            <div class="row">
                                <div class="col-md-12">
                                    @if(Sentinel::hasAccess('grants.notes.create'))
                                        <a href="#add_note_modal"
                                           data-toggle="modal" class="btn btn-info pull-right"><i
                                                    class="fa fa-plus"></i> {{trans_choice('general.add',1)}} {{trans_choice('general.note',1)}}
                                        </a>
                                    @endif
                                </div>
                                <div class="col-md-12 table-responsive">
                                    <table class="table table-hover table-striped" id="">
                                        <thead>
                                        <tr>
                                            <th>{{ trans_choice('general.note',1) }}</th>
                                            <th>{{ trans('general.date') }}</th>
                                            <th>{{ trans('general.created_by') }}</th>
                                            <th>{{ trans_choice('general.action',1) }}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @foreach(\App\Models\Note::where('reference_id',$grant->id)->where('type','grant')->get() as $key)
                                            <tr>
                                                <td>{!!   $key->notes !!}</td>
                                                <td>{!!   $key->created_at !!}</td>
                                                <td>
                                                    @if(!empty($key->created_by))
                                                        {{$key->created_by->first_name}} {{$key->created_by->last_name}}
                                                    @endif
                                                </td>
                                                <td>
                                                    <a data-id="{{$key->id}}" href="#" data-toggle="modal"
                                                       data-target="#view_note"><i class="fa fa-eye"></i> </a>
                                                    @if(Sentinel::hasAccess('grants.notes.update'))
                                                        <a data-id="{{$key->id}}" href="#" data-toggle="modal"
                                                           data-target="#edit_note"><i class="fa fa-edit"></i> </a>
                                                    @endif
                                                    @if(Sentinel::hasAccess('grants.notes.delete'))
                                                        <a class="confirm"
                                                           href="{{url('grant/note/'.$key->id.'/delete')}}"><i
                                                                    class="fa fa-trash"></i> </a>
                                                    @endif
                                                </td>
                                            </tr>
                                        @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    @endif
                    @if($grant->client_type=="group")
                        <div class="tab-pane" id="group_allocation">
                            <div class="row">
                                <div class="col-md-12 table-responsive">
                                    <table class="table table-hover table-striped" id="">
                                        <thead>
                                        <tr>
                                            <th>{{ trans_choice('general.name',1) }}</th>
                                            <th>{{ trans('general.id') }}</th>
                                            <th>{{ trans('general.amount') }}</th>
                                            <th>{{ trans_choice('general.action',1) }}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        @foreach($grant->group_allocation as $key)
                                            <tr>
                                                @if(!empty($key->client))
                                                    <td>
                                                        @if($key->client->client_type=="individual")
                                                            {{$key->client->first_name}} {{$key->client->middle_name}} {{$key->client->last_name}}
                                                        @else
                                                            {{$key->client->full_name}}
                                                        @endif
                                                    </td>
                                                    <td>{{$key->client->account_no}}</td>
                                                    <td>
                                                        {{number_format($key->amount,2)}}
                                                    </td>
                                                    <td>
                                                        <a class="" href="{{url('client/'.$key->client_id.'/show')}}"><i
                                                                    class="fa fa-eye"></i> </a>
                                                    </td>
                                                @endif
                                            </tr>
                                        @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="change_grant_officer_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{{trans_choice('general.change',1)}} {{trans_choice('general.grant',1)}} {{trans_choice('general.officer',1)}}</h4>
                </div>
                <form method="post" action="{{url('grant/'.$grant->id.'/change_grant_officer')}}"
                      class="form-horizontal "
                      enctype="multipart/form-data" id="change_grant_officer_form">
                    {{csrf_field()}}
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="grant_officer_id"
                                   class="control-label col-md-3">
                                {{trans_choice('general.grant',1)}} {{trans_choice('general.officer',1)}}
                            </label>
                            <div class="col-md-9">
                                <select name="grant_officer_id" class="form-control select2"
                                        id="grant_officer_id" required>
                                    <option></option>
                                    @foreach(\App\Models\User::all() as $key)
                                        @if(!Sentinel::findUserById($key->id)->inRole('client'))
                                            <option value="{{$key->id}}"
                                                    @if($grant->grant_officer_id==$key->id) selected @endif>{{$key->first_name}} {{$key->last_name}}</option>
                                        @endif
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left"
                                data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                        <button type="submit"
                                class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="add_document_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{{trans_choice('general.add',1)}} {{trans_choice('general.document',1)}}</h4>
                </div>
                <form method="post" action="{{url('grant/'.$grant->id.'/document/store')}}"
                      class="form-horizontal "
                      enctype="multipart/form-data" id="add_document_form">
                    {{csrf_field()}}
                    <div class="modal-body">

                        <div class="form-group">
                            <label for="document_name"
                                   class="control-label col-md-3">{{trans_choice('general.name',1)}}</label>
                            <div class="col-md-9">
                                <input type="text" name="name" class="form-control"
                                       value="{{old('name')}}"
                                       required id="document_name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="document_notes"
                                   class="control-label col-md-3">{{trans_choice('general.description',2)}}</label>
                            <div class="col-md-9">
       <textarea name="notes" class="form-control"
                 id="document_notes" rows="3">{{old('notes')}}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="document_attachment"
                                   class="control-label col-md-3">{{trans_choice('general.attachment',1)}}</label>
                            <div class="col-md-9">
                                <input type="file" name="attachment" class="form-control" required
                                       id="document_attachment">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left"
                                data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                        <button type="submit" class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="add_note_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{{trans_choice('general.add',1)}} {{trans_choice('general.note',1)}}</h4>
                </div>
                <form method="post" action="{{url('grant/'.$grant->id.'/note/store')}}"
                      class="form-horizontal "
                      enctype="multipart/form-data" id="add_note_form">
                    {{csrf_field()}}
                    <div class="modal-body">

                        <div class="form-group">
                            <label for="note_notes"
                                   class="control-label col-md-3">{{trans_choice('general.note',1)}}</label>
                            <div class="col-md-9">
       <textarea name="notes" class="form-control"
                 id="note_notes" rows="3" required>{{old('notes')}}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left"
                                data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                        <button type="submit" class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="view_note">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="edit_note">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="add_collateral_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{{trans_choice('general.add',1)}} {{trans_choice('general.collateral',1)}}</h4>
                </div>
                <form method="post" action="{{url('grant/'.$grant->id.'/collateral/store')}}"
                      class="form-horizontal"
                      enctype="multipart/form-data" id="add_collateral_form">
                    {{csrf_field()}}
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="collateral_type_id"
                                   class="control-label col-md-3">{{trans_choice('general.type',1)}}</label>
                            <div class="col-md-9">
                                <select name="collateral_type_id" class="select2 form-control"
                                        id="collateral_type_id" required>
                                    <option></option>
                                    @foreach(\App\Models\CollateralType::all() as $key)
                                        <option value="{{$key->id}}">{{$key->name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="value"
                                   class="control-label col-md-3">{{trans_choice('general.value',1)}}</label>
                            <div class="col-md-9">
                                <input type="number" name="value" class="form-control"
                                       value="{{old('value')}}"
                                       required id="value">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description"
                                   class="control-label col-md-3">{{trans_choice('general.description',1)}}</label>
                            <div class="col-md-9">
                                <input type="text" name="description" class="form-control"
                                       value="{{old('description')}}"
                                       required id="description">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="serial"
                                   class="control-label col-md-3">{{trans_choice('general.serial',1)}}</label>
                            <div class="col-md-9">
                                <input type="text" name="serial" class="form-control"
                                       value="{{old('serial')}}"
                                       required id="serial">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left"
                                data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                        <button type="submit" class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="view_collateral">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="edit_collateral">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal fade" id="add_guarantor_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">{{trans_choice('general.add',1)}} {{trans_choice('general.guarantor',1)}}</h4>
                </div>
                <form method="post" action="{{url('grant/'.$grant->id.'/guarantor/store')}}"
                      class="form-horizontal"
                      enctype="multipart/form-data" id="add_guarantor_form">
                    {{csrf_field()}}
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="is_client"
                                   class="control-label col-md-3">{{trans_choice('general.existing',1)}} {{trans_choice('general.client',1)}}</label>
                            <div class="col-md-9">
                                <select name="is_client" class="select2 form-control"
                                        id="is_client" required>
                                    <option value="0">{{trans_choice('general.no',1)}}</option>
                                    <option value="1" selected>{{trans_choice('general.yes',1)}}</option>
                                </select>
                            </div>
                        </div>
                        <div class="" id="clients_div" style="">
                            <div class="form-group">
                                <label for="guarantor_client_id"
                                       class="control-label col-md-3">{{trans_choice('general.client',1)}}</label>
                                <div class="col-md-9">
                                    <select name="client_id" class="form-control select2" id="guarantor_client_id">
                                        <option></option>
                                        @foreach(\App\Models\Client::where('status', 'active')->get() as $key)
                                            <option value="{{$key->id}}">
                                                @if($key->client_type=="individual")
                                                    {{$key->first_name}} {{$key->middle_name}} {{$key->last_name}}
                                                    ({{$key->account_no}})
                                                @else
                                                    {{$key->full_name}} ({{$key->account_no}}
                                                    )
                                                @endif
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="lock_funds"
                                       class="control-label col-md-3">{{trans_choice('general.lock_funds',1)}}</label>
                                <div class="col-md-9">
                                    <select name="lock_funds" class="select2 form-control"
                                            id="lock_funds">
                                        <option value="0" selected>{{trans_choice('general.no',1)}}</option>
                                        <option value="1">{{trans_choice('general.yes',1)}}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="client_relationship_id"
                                   class="control-label col-md-3">{{trans_choice('general.relationship',1)}}</label>
                            <div class="col-md-9">
                                <select name="client_relationship_id" class="select2 form-control"
                                        id="client_relationship_id" required>
                                    <option></option>
                                    @foreach(\App\Models\ClientRelationship::all() as $key)
                                        <option value="{{$key->id}}">{{$key->name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div id="new_client_div">
                            <div class="form-group">
                                <label for="guarantor_first_name"
                                       class="control-label col-md-3">{{trans_choice('general.first_name',1)}}</label>
                                <div class="col-md-9">
                                    <input type="text" name="first_name" class="form-control"
                                           value="{{old('first_name')}}"
                                           required id="guarantor_first_name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="guarantor_middle_name"
                                       class="control-label col-md-3">{{trans_choice('general.middle_name',1)}}</label>
                                <div class="col-md-9">
                                    <input type="text" name="middle_name" class="form-control"
                                           value="{{old('middle_name')}}"
                                           id="guarantor_middle_name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="guarantor_last_name"
                                       class="control-label col-md-3">{{trans_choice('general.last_name',1)}}</label>
                                <div class="col-md-9">
                                    <input type="text" name="last_name" class="form-control"
                                           value="{{old('last_name')}}"
                                           required id="guarantor_last_name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="guarantor_mobile"
                                       class="control-label col-md-3">{{trans_choice('general.mobile',1)}}</label>
                                <div class="col-md-9">
                                    <input type="text" name="mobile" class="form-control"
                                           value="{{old('mobile')}}"
                                           id="guarantor_mobile">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="guarantor_gender"
                                       class="control-label col-md-3">{{trans_choice('general.gender',1)}}</label>
                                <div class="col-md-9">
                                    <select name="gender" class="form-control" id="guarantor_gender">
                                        <option value="male">{{trans('general.male')}}</option>
                                        <option value="female">{{trans('general.female')}}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="guarantor_address"
                                       class="control-label col-md-3">{{trans_choice('general.address',1)}}</label>
                                <div class="col-md-9">
                                    <input type="text" name="guarantor_address" class="form-control"
                                           value=""
                                           id="guarantor_address">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="guarantor_amount"
                                   class="control-label col-md-3">{{trans_choice('general.amount',1)}}</label>
                            <div class="col-md-9">
                                <input type="number" name="amount" class="form-control"
                                       value="{{old('amount')}}"
                                       required id="guarantor_amount">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left"
                                data-dismiss="modal">{{trans_choice('general.close',1)}}</button>
                        <button type="submit" class="btn btn-primary">{{trans_choice('general.save',1)}}</button>
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="view_guarantor">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="edit_guarantor">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>


@endsection
@section('footer-scripts')
    <script>
        if ($("#is_client").val() == 1) {
            $("#clients_div").show();
            $("#new_client_div").hide();
            $("#guarantor_client_id").attr('required', 'required');
            $("#guarantor_first_name").removeAttr('required');
            $("#guarantor_last_name").removeAttr('required');
            $("#guarantor_mobile").removeAttr('required');
        } else if ($("#is_client").val() == 0) {
            $("#clients_div").hide();
            $("#new_client_div").show();
            $("#guarantor_client_id").removeAttr('required');
            $("#guarantor_first_name").attr('required', 'required');
            $("#guarantor_last_name").attr('required', 'required');
            $("#guarantor_mobile").attr('required', 'required');
        } else {
            $("#clients_div").hide();
            $("#clients_div").hide();
        }
        $("#is_client").change(function (e) {
            if ($("#is_client").val() == 1) {
                $("#clients_div").show();
                $("#new_client_div").hide();
                $("#guarantor_client_id").attr('required', 'required');
                $("#guarantor_first_name").removeAttr('required');
                $("#guarantor_last_name").removeAttr('required');
                $("#guarantor_mobile").removeAttr('required');
            } else if ($("#is_client").val() == 0) {
                $("#clients_div").hide();
                $("#new_client_div").show();
                $("#guarantor_client_id").removeAttr('required');
                $("#guarantor_first_name").attr('required', 'required');
                $("#guarantor_last_name").attr('required', 'required');
                $("#guarantor_mobile").attr('required', 'required');
            } else {
                $("#clients_div").hide();
                $("#clients_div").hide();
            }
        });
        $('#view_note').on('shown.bs.modal', function (e) {
            var id = $(e.relatedTarget).data('id');
            $.ajax({
                type: 'GET',
                url: "{!!  url('grant/note') !!}/" + id + "/show",
                success: function (data) {
                    $(e.currentTarget).find(".modal-content").html(data);
                }
            });
        });
        $('#edit_note').on('shown.bs.modal', function (e) {
            var id = $(e.relatedTarget).data('id');
            $.ajax({
                type: 'GET',
                url: "{!!  url('grant/note') !!}/" + id + "/edit",
                success: function (data) {
                    $(e.currentTarget).find(".modal-content").html(data);
                }
            });
        })
        $('#view_collateral').on('shown.bs.modal', function (e) {
            var id = $(e.relatedTarget).data('id');
            $.ajax({
                type: 'GET',
                url: "{!!  url('grant/collateral') !!}/" + id + "/show",
                success: function (data) {
                    $(e.currentTarget).find(".modal-content").html(data);
                }
            });
        });
        $('#edit_collateral').on('shown.bs.modal', function (e) {
            var id = $(e.relatedTarget).data('id');
            $.ajax({
                type: 'GET',
                url: "{!!  url('grant/collateral') !!}/" + id + "/edit",
                success: function (data) {
                    $(e.currentTarget).find(".modal-content").html(data);
                }
            });
        });
        $('#view_guarantor').on('shown.bs.modal', function (e) {
            var id = $(e.relatedTarget).data('id');
            $.ajax({
                type: 'GET',
                url: "{!!  url('grant/guarantor') !!}/" + id + "/show",
                success: function (data) {
                    $(e.currentTarget).find(".modal-content").html(data);
                }
            });
        });
        $('#edit_guarantor').on('shown.bs.modal', function (e) {
            var id = $(e.relatedTarget).data('id');
            $.ajax({
                type: 'GET',
                url: "{!!  url('grant/guarantor') !!}/" + id + "/edit",
                success: function (data) {
                    $(e.currentTarget).find(".modal-content").html(data);
                }
            });
        });
        $("#add_document_form").validate();
        $("#add_collateral_form").validate();
        $("#add_guarantor_form").validate();
        $("#add_note_form").validate();
        $("#approve_grant_form").validate();
        $("#decline_grant_form").validate();
        $("#add_charge_form").validate();
        $("#waive_interest_form").validate();
        $("#write_off_grant_form").validate();
        $('#data-table').DataTable({
            dom: 'frtip',
            "paging": true,
            "lengthChange": true,
            "displayLength": 15,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": true,
            "order": [[4, "desc"]],
            "columnDefs": [
                {"orderable": false, "targets": []}
            ],
            "language": {
                "lengthMenu": "{{ trans('general.lengthMenu') }}",
                "zeroRecords": "{{ trans('general.zeroRecords') }}",
                "info": "{{ trans('general.info') }}",
                "infoEmpty": "{{ trans('general.infoEmpty') }}",
                "search": "{{ trans('general.search') }}",
                "infoFiltered": "{{ trans('general.infoFiltered') }}",
                "paginate": {
                    "first": "{{ trans('general.first') }}",
                    "last": "{{ trans('general.last') }}",
                    "next": "{{ trans('general.next') }}",
                    "previous": "{{ trans('general.previous') }}"
                }
            },
            responsive: false
        });
        $('#repayments-data-table').DataTable({
            dom: 'frtip',
            "paging": true,
            "lengthChange": true,
            "displayLength": 15,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": true,
            "order": [[1, "asc"]],
            "columnDefs": [
                {"orderable": false, "targets": []}
            ],
            "language": {
                "lengthMenu": "{{ trans('general.lengthMenu') }}",
                "zeroRecords": "{{ trans('general.zeroRecords') }}",
                "info": "{{ trans('general.info') }}",
                "infoEmpty": "{{ trans('general.infoEmpty') }}",
                "search": "{{ trans('general.search') }}",
                "infoFiltered": "{{ trans('general.infoFiltered') }}",
                "paginate": {
                    "first": "{{ trans('general.first') }}",
                    "last": "{{ trans('general.last') }}",
                    "next": "{{ trans('general.next') }}",
                    "previous": "{{ trans('general.previous') }}"
                }
            },
            responsive: false
        });
    </script>
@endsection

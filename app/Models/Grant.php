<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Grant extends Model
{

    protected $table = "grants";


    public function group_allocation()
    {
        return $this->hasMany(GroupLoanAllocation::class, 'loan_id', 'id');
    }

    public function payment_detail()
    {
        return $this->hasOne(PaymentDetail::class, 'id', 'payment_detail_id');
    }

    public function collateral()
    {
        return $this->hasMany(Collateral::class, 'grant_id', 'id');
    }

    public function guarantors()
    {
        return $this->hasMany(Guarantor::class, 'grant_id', 'id');
    }

    public function client()
    {
        return $this->hasOne(Client::class, 'id', 'client_id');
    }

    public function group()
    {
        return $this->hasOne(Group::class, 'id', 'group_id');
    }

    public function currency()
    {
        return $this->hasOne(Currency::class, 'id', 'currency_id');
    }

    public function fund()
    {
        return $this->hasOne(Fund::class, 'id', 'fund_id');
    }

    public function grant_purpose()
    {
        return $this->hasOne(LoanPurpose::class, 'id', 'grant_purpose_id');
    }

    public function grant_product()
    {
        return $this->hasOne(LoanProduct::class, 'id', 'grant_product_id');
    }

    public function office()
    {
        return $this->hasOne(Office::class, 'id', 'office_id');
    }


    public function grant_officer()
    {
        return $this->hasOne(User::class, 'id', 'grant_officer_id');
    }

    public function created_by()
    {
        return $this->hasOne(User::class, 'id', 'created_by_id');
    }

    public function approved_by()
    {
        return $this->hasOne(User::class, 'id', 'approved_by_id');
    }

    public function rejected_by()
    {
        return $this->hasOne(User::class, 'id', 'rejected_by_id');
    }

    public function declined_by()
    {
        return $this->hasOne(User::class, 'id', 'declined_by_id');
    }

    public function withdrawn_by()
    {
        return $this->hasOne(User::class, 'id', 'withdrawn_by_id');
    }

    public function rescheduled_by()
    {
        return $this->hasOne(User::class, 'id', 'rescheduled_by_id');
    }

    public function closed_by()
    {
        return $this->hasOne(User::class, 'id', 'closed_by_id');
    }

    public function disbursed_by()
    {
        return $this->hasOne(User::class, 'id', 'disbursed_by_id');
    }
}

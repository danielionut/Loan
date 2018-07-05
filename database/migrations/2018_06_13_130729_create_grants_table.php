<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateGrantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('grants', function (Blueprint $table) {
            $table->increments('id');
            $table->enum('client_type', ['client', 'group'])->default('client');
            $table->integer('grant_product_id')->nullable();
            $table->integer('payment_detail_id')->nullable();
            $table->integer('client_id')->nullable();
            $table->integer('office_id')->nullable();
            $table->integer('group_id')->nullable();
            $table->integer('grant_fund_id')->nullable();
            $table->integer('grant_purpose_id')->nullable();
            $table->integer('currency_id')->nullable();
            $table->integer('decimals')->default(2);
            $table->string('account_number')->nullable();
            $table->string('external_id')->nullable();
            $table->integer('grant_officer_id')->nullable();
            $table->decimal('amount', 65, 4)->nullable();
            $table->decimal('applied_amount', 65, 4)->nullable();
            $table->decimal('approved_amount', 65, 4)->nullable();
            $table->date('expected_disbursement_date')->nullable();
            $table->date('disbursement_date')->nullable();
            $table->enum('status', array(
                'new',
                'pending',
                'approved',
                'need_changes',
                'disbursed',
                'declined',
                'rejected',
                'withdrawn',
                'closed',
                'paid'
            ))->default('pending');
            $table->integer('created_by_id')->nullable();
            $table->integer('modified_by_id')->nullable();
            $table->integer('approved_by_id')->nullable();
            $table->integer('need_changes_by_id')->nullable();
            $table->integer('withdrawn_by_id')->nullable();
            $table->integer('declined_by_id')->nullable();
            $table->integer('written_off_by_id')->nullable();
            $table->integer('disbursed_by_id')->nullable();
            $table->integer('closed_by_id')->nullable();
            $table->date('created_date')->nullable();
            $table->date('modified_date')->nullable();
            $table->date('approved_date')->nullable();
            $table->date('need_changes_date')->nullable();
            $table->date('withdrawn_date')->nullable();
            $table->date('declined_date')->nullable();
            $table->date('written_off_date')->nullable();
            $table->date('closed_date')->nullable();
            $table->string('month')->nullable();
            $table->string('year')->nullable();
            $table->text('notes')->nullable();
            $table->text('approved_notes')->nullable();
            $table->text('declined_notes')->nullable();
            $table->text('written_off_notes')->nullable();
            $table->text('disbursed_notes')->nullable();
            $table->text('withdrawn_notes')->nullable();
            $table->text('closed_notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('grants');
    }
}

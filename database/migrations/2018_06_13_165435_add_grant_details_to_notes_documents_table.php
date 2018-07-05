<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddGrantDetailsToNotesDocumentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("ALTER TABLE notes CHANGE COLUMN type type ENUM( 'client', 'loan','group', 'savings', 'identification', 'shares', 'repayment','grant')");
        DB::statement("ALTER TABLE documents CHANGE COLUMN type type ENUM( 'client', 'loan','group', 'savings', 'identification', 'shares', 'repayment','grant')");

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}

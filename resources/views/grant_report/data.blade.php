@extends('layouts.master')
@section('title'){{trans_choice('general.grant',1)}} {{trans_choice('general.report',2)}}
@endsection
@section('content')
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title"> {{trans_choice('general.grant',1)}} {{trans_choice('general.report',2)}}</h3>

            <div class="box-tools pull-right">

            </div>
        </div>
        <div class="box-body">
            <table id="" class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>{{trans_choice('general.name',1)}}</th>
                    <th>{{ trans_choice('general.description',1) }}</th>
                    <th>{{ trans_choice('general.action',1) }}</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td>
                        <a href="{{url('report/grant_report/disbursement_report')}}">{{trans_choice('general.disbursement',2)}} {{trans_choice('general.report',1)}}</a>
                    </td>
                    <td>
                        {{trans_choice('general.grant_disbursement_report_description',1)}}
                    </td>
                    <td><a href="{{url('report/grant_report/disbursement_report')}}"><i class="icon-search4"></i> </a>
                    </td>
                </tr>


                </tbody>
            </table>
        </div>
        <!-- /.box-body -->
    </div>
    <!-- /.box -->
@endsection
@section('footer-scripts')

@endsection

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
        font-size: 10px;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }


    .style-1 {
        color: white;
        padding-left: 10pt;
        font-size: 14pt;
        font-family: "Arial";
        font-weight: bold;
        font-style: normal;
        text-decoration: none;
        text-align: left;
        word-spacing: 0pt;
        letter-spacing: 0pt;
        white-space: pre-wrap;
        background-color: #339933;
    }
    .style-2 {
        color: black;
        padding-right: 1pt;
        font-size: 8pt;
        font-family: "Arial";
        font-weight: bold;
        font-style: normal;
        text-decoration: none;
        text-align: left;
        word-spacing: 0pt;
        letter-spacing: 0pt;
        white-space: pre-wrap;
    }
    .style-3 {
        color: black;
        padding-right: 1pt;
        font-size: 8pt;
        font-family: "Arial Narrow";
        font-weight: normal;
        font-style: normal;
        text-decoration: none;
        text-align: right;
        word-spacing: 0pt;
        letter-spacing: 0pt;
        white-space: pre-wrap;
    }
</style>
<div>

    <table class="table  table-condensed table-hover">
        <tbody>
        <tr style="height: 25pt">
            <td colspan="6" valign="middle"
                class="style-1"> {{trans_choice('general.grant',1)}}  {{trans_choice('general.disbursement',2)}}</td>
        </tr>
        <tr style="height: 15pt">
            <td valign="middle" class="style-2">{{trans_choice('general.from',1)}} :</td>
            <td valign="middle" class="style-3">{{$start_date}}</td>
            <td colspan="2" valign="middle"
                class="style-4">{{trans_choice('general.report',1)}} {{trans_choice('general.run',1)}} {{trans_choice('general.date',1)}}
                :
            </td>
            <td colspan="2" valign="middle" class="style-5"> {{date("Y-m-d H:i:s")}}</td>
        </tr>
        <tr style="height: 45pt">
            <td valign="middle" class="style-2">{{trans_choice('general.to',1)}} :</td>
            <td valign="middle" class="style-3">{{$end_date}}</td>
            <td colspan="4"></td>
        </tr>
        <tr class="">
            <td>{{trans_choice('general.id',1)}}</td>
            <td>{{trans_choice('general.client',1)}}</td>
            <td>{{trans_choice('general.grant',1)}} {{trans_choice('general.officer',1)}} </td>
            <td>{{trans_choice('general.amount',1)}}</td>
            <td>{{trans_choice('general.disbursement',1)}} {{trans_choice('general.date',1)}}</td>
            <td>{{trans_choice('general.channel',1)}}</td>
        </tr>
        <?php
        $total_amount = 0;
        $decimals = 2;
        ?>
        @foreach($data as $key)
            <?php

            $decimals = $key->decimals;

            $amount = $key->amount;
            $total_amount = $total_amount + $amount;

            ?>
            <tr>
                <td>{{$key->id}}</td>
                <td>

                    @if($key->client_type=="client")
                        @if(!empty($key->client))
                            @if($key->client->client_type=="individual")
                                {{$key->client->first_name}} {{$key->client->middle_name}} {{$key->client->last_name}}
                            @endif
                            @if($key->client->client_type=="business")
                                {{$key->client->full_name}}
                            @endif
                        @endif
                    @endif
                    @if($key->client_type=="group")
                        @if(!empty($key->group))
                            {{$key->group->name}}
                        @endif
                    @endif

                </td>
                <td>
                    @if(!empty($key->grant_officer))
                        {{$key->grant_officer->first_name}}  {{$key->grant_officer->last_name}}
                    @endif
                </td>
                <td>{{number_format($amount,$decimals)}}</td>
                <td>{{$key->disbursement_date}}</td>
                <td>
                    @if(!empty($key->payment_detail))
                        @if(!empty($key->payment_detail->type))
                            {{$key->payment_detail->type->name}}
                        @endif
                    @endif
                </td>
            </tr>
        @endforeach
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3"></td>
            <td><b>{{number_format($total_amount,$decimals)}}</b></td>
            <td colspan="2"></td>
        </tr>
        </tfoot>
    </table>
</div>
@extends('layouts.master')
@section('title')
    {{ trans_choice('general.edit',1) }} {{ trans_choice('general.other_income',1) }}
@endsection

@section('content')
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">{{ trans_choice('general.edit',1) }} {{ trans_choice('general.other_income',1) }}</h3>

            <div class="box-tools pull-right">

            </div>
        </div>
        <form method="post" action="{{url('other_income/'.$other_income->id.'/update')}}" class="form-horizontal"
              enctype="multipart/form-data">
            {{csrf_field()}}
            <div class="box-body">
                <div class="form-group">
                    <label for="office_id"
                           class="control-label col-md-2">{{trans_choice('general.branch',1)}}</label>
                    <div class="col-md-3">
                        <select name="office_id" class="form-control select2" id="office_id" required>
                            <option></option>
                            @foreach(\App\Models\Office::all() as $key)
                                <option value="{{$key->id}}"
                                        @if($other_income->office_id==$key->id) selected @endif>{{$key->name}}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="other_income_type_id"
                           class="control-label col-md-2">{{trans_choice('general.type',1)}}</label>
                    <div class="col-md-3">
                        <select name="other_income_type_id" class="form-control select2" id="other_income_type_id"
                                required>
                            <option></option>
                            @foreach(\App\Models\OtherIncomeType::all() as $key)
                                <option value="{{$key->id}}"
                                        @if($other_income->other_income_type_id==$key->id) selected @endif>{{$key->name}}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="name"
                           class="control-label col-md-2">{{trans_choice('general.name',1)}}</label>
                    <div class="col-md-3">
                        <input type="text" name="name" class="form-control"
                               value="{{$other_income->name}}" required
                               id="name">
                    </div>
                </div>
                <div class="form-group">
                    <label for="date"
                           class="control-label col-md-2">{{trans_choice('general.date',1)}}</label>
                    <div class="col-md-3">
                        <input type="text" name="date" class="form-control date-picker"
                               value="{{$other_income->date}}"
                               id="date">
                    </div>
                </div>
                <div class="form-group">
                    <label for="amount"
                           class="control-label col-md-2">{{trans_choice('general.amount',1)}}</label>
                    <div class="col-md-3">
                        <input type="number" name="amount" class="form-control"
                               value="{{$other_income->amount}}" required
                               id="amount">
                    </div>
                </div>
                <div class="form-group">
                    <label for="notes"
                           class="control-label col-md-2">{{trans_choice('general.note',2)}}</label>
                    <div class="col-md-8">
                        <textarea name="notes" class="form-control "
                                  placeholder=""
                                  id="notes" rows="3">{{$other_income->notes}}</textarea>
                    </div>
                </div>
                @if(\App\Models\Setting::where('setting_key','enable_custom_fields')->first()->setting_value==1)
                    @foreach(\App\Models\CustomField::where('category','other_income')->get() as $key)
                        <div class="form-group">
                            <label for="notes"
                                   class="control-label col-md-2">{{$key->name}}</label>
                            <div class="col-md-8">
                                @if($key->field_type=="number")
                                    <input type="number" class="form-control" name="custom_field_{{$key->id}}"
                                           @if($key->required==1) required
                                           @endif value="@if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first())){{\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name}} @endif">
                                @endif
                                @if($key->field_type=="textfield")
                                    <input type="text" class="form-control" name="custom_field_{{$key->id}}"
                                           @if($key->required==1) required
                                           @endif value="@if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first())){{\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name}} @endif">
                                @endif
                                @if($key->field_type=="date")
                                    <input type="text" class="form-control date-picker" name="custom_field_{{$key->id}}"
                                           @if($key->required==1) required
                                           @endif value="@if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first())){{\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name}} @endif">
                                @endif
                                @if($key->field_type=="textarea")
                                    <textarea class="form-control" name="custom_field_{{$key->id}}"
                                              @if($key->required==1) required @endif>@if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first())){{\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name}} @endif</textarea>
                                @endif
                                @if($key->field_type=="decimal")
                                    <input type="text" class="form-control touchspin" name="custom_field_{{$key->id}}"
                                           @if($key->required==1) required
                                           @endif value="@if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first())){{\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name}} @endif">
                                @endif
                                @if($key->field_type=="select")
                                    <select class="form-control touchspin" name="custom_field_{{$key->id}}"
                                            @if($key->required==1) required @endif>
                                        @if($key->required!=1)
                                            <option value=""></option>
                                        @else
                                            <option value="" disabled selected>Select...</option>
                                        @endif
                                        @foreach(explode(',',$key->select_values) as $v)
                                            @if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()))
                                                @if(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name==$v)
                                                    <option selected>{{$v}}</option>
                                                @else
                                                    <option>{{$v}}</option>
                                                @endif
                                            @else
                                                <option>{{$v}}</option>
                                            @endif

                                        @endforeach
                                    </select>
                                @endif
                                @if($key->field_type=="radiobox")
                                    @foreach(explode(',',$key->radio_box_values) as $v)
                                        <div class="radio">
                                            <label>
                                                @if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()))
                                                    @if(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()->name==$v)
                                                        <input type="radio" name="custom_field_{{$key->id}}"
                                                               id="{{$key->id}}" value="{{$v}}"
                                                               @if($key->required==1) required @endif checked>
                                                    @else
                                                        <input type="radio" name="custom_field_{{$key->id}}"
                                                               id="{{$key->id}}" value="{{$v}}"
                                                               @if($key->required==1) required @endif>
                                                    @endif
                                                @else
                                                    <input type="radio" name="custom_field_{{$key->id}}"
                                                           id="{{$key->id}}" value="{{$v}}"
                                                           @if($key->required==1) required @endif>
                                                @endif

                                                <b>{{$v}}</b>
                                            </label>
                                        </div>
                                    @endforeach
                                @endif
                                @if($key->field_type=="checkbox")
                                    @if(!empty(\App\Models\CustomFieldMeta::where('custom_field_id',$key->id)->where('parent_id',$other_income->id)->where('category','other_income')->first()))
                                        <?php $c = unserialize(\App\Models\CustomFieldMeta::where('custom_field_id',
                                            $key->id)->where('parent_id', $other_income->id)->where('category',
                                            'other_income')->first()->name); ?>

                                        @foreach(explode(',',$key->checkbox_values) as $v)
                                            <div class="checkbox">
                                                <label>
                                                    @if(array_key_exists($v,$c))
                                                        @if($c[$v]==$v)
                                                            <input type="checkbox"
                                                                   name="custom_field_{{$key->id}}[{{$v}}]"
                                                                   id="{{$key->id}}"
                                                                   value="{{$v}}"
                                                                   @if($key->required==1) required @endif checked>
                                                        @else
                                                            <input type="checkbox"
                                                                   name="custom_field_{{$key->id}}[{{$v}}]"
                                                                   id="{{$key->id}}"
                                                                   value="{{$v}}"
                                                                   @if($key->required==1) required @endif>
                                                        @endif
                                                    @else
                                                        <input type="checkbox" name="custom_field_{{$key->id}}[{{$v}}]"
                                                               id="{{$key->id}}"
                                                               value="{{$v}}"
                                                               @if($key->required==1) required @endif>
                                                    @endif
                                                    <b>{{$v}}</b>
                                                </label>
                                            </div>
                                        @endforeach
                                    @else
                                        @foreach(explode(',',$key->checkbox_values) as $v)
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="custom_field_{{$key->id}}[{{$v}}]"
                                                           id="{{$key->id}}"
                                                           value="{{$v}}"
                                                           @if($key->required==1) required @endif>
                                                    <b>{{$v}}</b>
                                                </label>
                                            </div>
                                        @endforeach
                                    @endif
                                @endif
                            </div>
                        </div>
                    @endforeach
                @endif
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <div class="heading-elements">
                    <button type="submit" class="btn btn-primary pull-right">{{trans_choice('general.save',1)}}</button>
                </div>
            </div>
        </form>
    </div>
    <!-- /.box -->
@endsection
@section('footer-scripts')
    <script>

        function delete_file(e) {
            var id = e.id;
            swal({
                title: 'Are you sure?',
                text: '',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Ok',
                cancelButtonText: 'Cancel'
            }).then(function () {
                $.ajax({
                    type: 'GET',
                    url: "{!!  url('other_income/'.$other_income->id) !!}/delete_file?id=" + id,
                    success: function (data) {
                        $("#file_" + id + "_span").remove();
                        swal({
                            title: 'Deleted',
                            text: 'File successfully deleted',
                            type: 'success',
                            showCancelButton: false,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Ok',
                            timer: 2000
                        })
                    }
                });
            })

        }

    </script>
@endsection


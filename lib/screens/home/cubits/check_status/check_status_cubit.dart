import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kitchen_task/core/common/api_constants.dart';
import 'package:kitchen_task/screens/home/common/common_list.dart';
import 'package:kitchen_task/screens/home/model/order_model.dart';
import 'package:meta/meta.dart';

import '../fetch_preparedData/fetch_prepared_data_cubit.dart';
import '../get_data/get_data_cubit.dart';

part 'check_status_state.dart';

class CheckStatusCubit extends Cubit<CheckStatusState> {
  CheckStatusCubit() : super(CheckStatusInitial()) {

    CheckStatusData();
  }

  // Functions

  void CheckStatusData() async {
    var box = await Hive.openBox("authBox");
    String authVar = box.get("authToken");

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authVar'
      };
      var data = json.encode({"status": status, "id": id});
      var dio = Dio();
      Response response = await dio.post(
        ApiConstants.apiAllOrderCheckStatusUrl,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );


      if (response.statusCode == 200) {
        print(json.encode(response.data));
      }
    } catch (e) {
      print("Error - CheckStatus");
    }
  }
}

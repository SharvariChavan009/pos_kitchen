import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kitchen_task/core/common/api_constants.dart';
import 'package:kitchen_task/screens/home/common/common_list.dart';
import 'package:kitchen_task/screens/home/model/order_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial()) {
    fetchAllData();
  }

  // Functions
  Dio dio = Dio();

  // Fetch All Data
  void fetchAllData() async {
    
    var box = await Hive.openBox("authBox");
    String authVar = box.get("authToken");

    try {
      dio.interceptors.add(PrettyDioLogger());

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authVar'
      };

      Response response = await dio.get(
        ApiConstants.apiAllOrderUrl,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data['data'] as List;
        responseData.forEach((i) => allData.add(OrderModel.fromJson(i)));
        emit(GetAllDataLoadedState(data: allData));
        print("<< User Token: $authVar >>");

      }
    } catch (e) {
      emit(GetAllDataErrorState());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:kitchen_task/core/common/api_constants.dart';
import 'package:kitchen_task/screens/home/common/common_list.dart';
import 'package:kitchen_task/screens/home/model/order_model.dart';
import 'package:meta/meta.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'ready_data_state.dart';

class ReadyDataCubit extends Cubit<ReadyDataState> {
  ReadyDataCubit() : super(ReadyDataInitial()) {
    readyData();
  }

  Dio dio = Dio();
  void readyData() async {
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
        allOrderData.clear();
        responseData.forEach((i) => allOrderData.add(OrderModel.fromJson(i)));
        readyOrderData =
            allOrderData.where((order) => order.status == "Ready").toList();
        print("Ready order count = ${prepareOrderData.length}");
        emit(ReadyDataLoadedState(readyList: readyOrderData));
      }
    } catch (e) {
      emit(ReadyDataErrorState());
    }
  }
}

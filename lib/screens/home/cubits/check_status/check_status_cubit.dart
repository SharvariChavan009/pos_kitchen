import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:kitchen_task/screens/home/model/order_model.dart';
import 'package:meta/meta.dart';

part 'check_status_state.dart';

class CheckStatusCubit extends Cubit<CheckStatusState> {
  CheckStatusCubit() : super(CheckStatusInitial()) {}

  // Functions

  void CheckData(String status, String id) async {
    try {
      var dio = Dio();
      Response response = await dio.post("https://reqres.in/api/users", data: {
        "name": status,
        "job": id,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {}
    } catch (e) {}
  }
}

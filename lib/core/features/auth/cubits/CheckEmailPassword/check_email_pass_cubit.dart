import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';

import 'package:kitchen_task/core/features/auth/cubits/password/login_cubit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'check_email_pass_state.dart';

class CheckEmailPassCubit extends Cubit<CheckEmailPassState> {
  CheckEmailPassCubit() : super(CheckEmailPassInitial()) {}

  void Loginvalidation3(String email, String pass) async {
    // if 3
    if ((email.isNotEmpty && EmailValidator.validate(email) == true) &&
        (pass.length >= 7)) {
      print("In - Correct Validation");
      emit(LoadingState());
      try {
        var dio = Dio();

        dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
        ));

        var url = "http://localhost:8000/api/login";
        Response response = await dio.post(url,
            data: {"email": email, "password": pass, "device_name": "desktop"});

        if (response.statusCode == 200) {
          print(response.statusCode);
          emit(LoginSuccessfulState());
          email = "";
          pass = "";
        }
      } catch (e) {
        emit(LoginFailedfulState());
        print("Error");
      }
    }
  }
}

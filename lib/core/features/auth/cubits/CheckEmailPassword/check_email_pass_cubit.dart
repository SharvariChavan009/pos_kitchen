import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';

import 'package:kitchen_task/core/features/auth/cubits/password/login_cubit.dart';

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
        Response response =
            await dio.post("http://localhost:8000/api/login", data: {
          "email": email,
          "password": pass,
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(LoginSuccessfulState());
          email = "";
          pass = "";
        }
      } catch (e) {
        emit(LoginFailedfulState());
      }
    }
  }
}

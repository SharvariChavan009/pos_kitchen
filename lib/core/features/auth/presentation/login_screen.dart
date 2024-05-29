import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_task/core/common/c_text_field.dart';
import 'package:kitchen_task/core/common/colors.dart';
import 'package:kitchen_task/core/common/common_messages.dart';
import 'package:kitchen_task/core/common/overlay.dart';
import 'package:kitchen_task/core/features/auth/cubits/CheckEmailPassword/check_email_pass_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/email/email_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/password/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    TextEditingController loginemailController = TextEditingController();
    TextEditingController loginpinController = TextEditingController();

    print("Screen Height: $screenHeight");
    print("Screen Width: $screenWidth");
// -----------------------------------------
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: BlocListener<CheckEmailPassCubit, CheckEmailPassState>(
          listener: (context, state) {
            if (state is LoginSuccessfulState) {}
            if (state is LoginFailedfulState) {
              //------- Snackbar ------------
              OverlayManager.showSnackbar(context,
                  type: ContentType.failure,
                  title: "Login Failed",
                  message: CustomMessages.loginFailed);
              //-----------------------------
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            height: screenHeight * 0.30,
            width: screenWidth * 0.90,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const CircleAvatar(
                    radius: 32, // Image radius
                    backgroundImage: NetworkImage(
                        'https://png.pngitem.com/pimgs/s/105-1050694_user-placeholder-image-png-transparent-png.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, bottom: 10, left: 40, right: 40),
                    child: GestureDetector(
                      onTap: () {
                        // -----------------
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            var screenSize = MediaQuery.of(context).size;
                            return Dialog(
                              backgroundColor: AppColors.primaryColor,
                              child: SizedBox(
                                width: screenSize.width *
                                    0.9, // 80% of screen width
                                height: screenSize.height *
                                    0.5, // 50% of screen height

                                child: Center(
                                  child: Container(
                                    color: AppColors.primaryColor,
                                    height: screenHeight * 0.42,
                                    width: screenWidth * 0.80,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0, bottom: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 120.0),
                                                  child: Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0,
                                                right: 10,
                                                left: 10),
                                            child: Container(
                                              width: screenWidth * 0.84,
                                              child: CustomTextField(
                                                controller:
                                                    loginemailController,
                                                hintText: "Email",
                                                borderColor:
                                                    AppColors.buttonColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0,
                                                  right: 10,
                                                  left: 10),
                                              child: BlocBuilder<EmailCubit,
                                                  EmailState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is EmailValidatorState) {
                                                    return Text(
                                                      state.errorMessage2,
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                },
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5, right: 10, left: 10),
                                            child: SizedBox(
                                              width: screenWidth * 0.84,
                                              child: CustomTextField(
                                                controller: loginpinController,
                                                obscureText: true,
                                                hintText: "PIN",
                                                borderColor:
                                                    AppColors.buttonColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0,
                                                  right: 10,
                                                  left: 10),
                                              child: BlocBuilder<LoginCubit,
                                                  LoginState>(
                                                builder: (context, state) {
                                                  if (state is ErrorState1) {
                                                    return Text(
                                                      state.errorMessage2,
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                },
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: BlocBuilder<LoginCubit,
                                                LoginState>(
                                              builder: (context, state) {
                                                if (state is LoadingState) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.grey,
                                                      backgroundColor:
                                                          Colors.blue,
                                                    ),
                                                  );
                                                }
                                                return GestureDetector(
                                                  onTap: () {
                                                    BlocProvider.of<EmailCubit>(
                                                            context)
                                                        .Loginvalidation1(
                                                            loginemailController
                                                                .text,
                                                            loginpinController
                                                                .text);

                                                    BlocProvider.of<LoginCubit>(
                                                            context)
                                                        .Loginvalidation(
                                                            loginemailController
                                                                .text,
                                                            loginpinController
                                                                .text);

                                                    BlocProvider.of<
                                                                CheckEmailPassCubit>(
                                                            context)
                                                        .Loginvalidation3(
                                                            loginemailController
                                                                .text,
                                                            loginpinController
                                                                .text);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .buttonColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Login",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        var screenSize =
                                                            MediaQuery.of(
                                                                    context)
                                                                .size;
                                                        return Dialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          child: SizedBox(
                                                            width: screenSize
                                                                    .width *
                                                                0.9, // 80% of screen width
                                                            height: screenSize
                                                                    .height *
                                                                0.4, // 50% of screen height

                                                            child: Center(
                                                              child: Container(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                height:
                                                                    screenHeight *
                                                                        0.42,
                                                                width:
                                                                    screenWidth *
                                                                        0.80,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              20.0,
                                                                          bottom:
                                                                              30),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 70.0),
                                                                            child:
                                                                                Text(
                                                                              "Reset Your Pin",
                                                                              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 20.0),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context, true);
                                                                              },
                                                                              child: const Icon(
                                                                                Icons.remove,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              20.0,
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              10),
                                                                      child:
                                                                          SizedBox(
                                                                        width: screenWidth *
                                                                            0.84,
                                                                        child:
                                                                            CustomTextField(
                                                                          controller:
                                                                              loginemailController,
                                                                          hintText:
                                                                              "Email",
                                                                          borderColor:
                                                                              AppColors.buttonColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10.0),
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppColors.buttonColor,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              "Send OTP",
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    "Forgot PIN ?",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        // ----------------
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 10.0, bottom: 10, left: 40, right: 40),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => SignupScreen()));
                  //     },
                  //     child: Text(
                  //       "Signp",
                  //       style: TextStyle(
                  //           color: AppColors.secondaryColor,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

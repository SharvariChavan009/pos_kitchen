import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kitchen_task/core/common/c_text_field.dart';
import 'package:kitchen_task/core/common/colors.dart';
import 'package:kitchen_task/core/common/common_messages.dart';
import 'package:kitchen_task/core/common/overlay.dart';
import 'package:kitchen_task/core/features/auth/cubits/CheckEmailPassword/check_email_pass_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/email/email_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/get_user_details/get_user_details_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/password/login_cubit.dart';
import 'package:kitchen_task/screens/home/order_list.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../images/image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    // -----------------------------------------
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    TextEditingController loginemailController = TextEditingController();
    TextEditingController loginpinController = TextEditingController();

    print("Screen Height: $screenHeight");
    print("Screen Width: $screenWidth");
// -----------------------------------------
    return Scaffold(
        backgroundColor: AppColors.scolor,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImage.splashScreen,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: BlocListener<CheckEmailPassCubit, CheckEmailPassState>(
              listener: (context, state) {
                if (state is LoginSuccessfulState) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => OrderListScreen()),
                      (Route route) => false);

                  BlocProvider.of<GetUserDetailsCubit>(context)
                      .getUserDetails();
                }
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
                  color: AppColors.newCardBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                height: screenHeight * 0.30,
                width: screenWidth * 0.40,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.whiteColor,
                        minRadius: 20,
                        maxRadius: 20,
                        child: ClipOval(
                          child: Image.asset(
                            AppImage
                                .appLogo1, // Replace with AppImage.appHeaderLogo if it's a constant string
                            fit: BoxFit.contain,
                            width: 30,
                            height: 30,
                          ),
                        ),
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
                                  backgroundColor:
                                      AppColors.cardBackgroundColor,
                                  child: SizedBox(
                                    width: screenSize.width *
                                        0.3, // 80% of screen width
                                    height: screenSize.height *
                                        0.5, // 50% of screen height

                                    child: Center(
                                      child: Container(
                                        color: AppColors.cardBackgroundColor,
                                        height: screenHeight * 0.50,
                                        width: screenWidth * 0.25,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                   Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 120.0),
                                                    child: Text(
                                                      optionName!.login,
                                                      style: TextStyle(
                                                          color: Colors.black,
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
                                                        color: Colors.black,
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
                                                  hintText: optionName!.email,
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
                                                  bottom: 5,
                                                  right: 10,
                                                  left: 10),
                                              child: SizedBox(
                                                width: screenWidth * 0.84,
                                                child: CustomTextField(
                                                  controller:
                                                      loginpinController,
                                                  obscureText: true,
                                                  inputType: CustomTextInputType
                                                      .password,
                                                  hintText: optionName!.pIN,
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                      BlocProvider.of<
                                                                  EmailCubit>(
                                                              context)
                                                          .Loginvalidation1(
                                                              loginemailController
                                                                  .text,
                                                              loginpinController
                                                                  .text);

                                                      BlocProvider.of<
                                                                  LoginCubit>(
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
                                                              .buttonBackgroundColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child:  Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            optionName!.login,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // loginemailController.text = "";
                                                      showDialog(
                                                        barrierDismissible:
                                                            false,
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
                                                                    .cardBackgroundColor,
                                                            child: SizedBox(
                                                              width: screenSize
                                                                      .width *
                                                                  0.3, // 80% of screen width
                                                              height: screenSize
                                                                      .height *
                                                                  0.5, // 50% of screen height

                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  color: AppColors
                                                                      .cardBackgroundColor,
                                                                  height:
                                                                      screenHeight *
                                                                          0.50,
                                                                  width:
                                                                      screenWidth *
                                                                          0.25,
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
                                                                             Padding(
                                                                              padding: EdgeInsets.only(left: 70.0),
                                                                              child: Text(
                                                                                optionName!.resetYourPin,
                                                                                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 20.0),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  Navigator.pop(context, true);
                                                                                  loginemailController.clear();
                                                                                },
                                                                                child: const Icon(
                                                                                  Icons.remove,
                                                                                  color: Colors.black,
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
                                                                          width:
                                                                              screenWidth * 0.84,
                                                                          child:
                                                                              CustomTextField(
                                                                            controller:
                                                                                loginemailController,
                                                                            hintText:
                                                                                optionName!.email,
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
                                                                              color: AppColors.buttonBackgroundColor,
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                               Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                optionName!.sendOTP,
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
                                                    child:  Text(
                                                      optionName!.forgotPIN,
                                                      style: TextStyle(
                                                        color: Colors.black,
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
                                );
                              },
                            );

                            // ----------------
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            child:  Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  optionName!.login,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

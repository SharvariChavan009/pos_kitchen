import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_task/core/common/colors.dart';
import 'package:kitchen_task/core/common/common_messages.dart';
import 'package:kitchen_task/core/common/label.dart';
import 'package:kitchen_task/core/common/overlay.dart';
import 'package:kitchen_task/core/features/auth/cubits/change_language/change_language_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/get_user_details/get_user_details_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/logout/logout_cubit.dart';
import 'package:kitchen_task/core/features/auth/presentation/login_screen.dart';
import 'package:kitchen_task/screens/home/common/common_list.dart';
import 'package:kitchen_task/screens/home/cubits/check_status/check_status_cubit.dart';
import 'package:kitchen_task/screens/home/cubits/fetch_preparedData/fetch_prepared_data_cubit.dart';

import 'package:kitchen_task/screens/home/cubits/get_data/get_data_cubit.dart';
import 'package:kitchen_task/screens/home/cubits/ready_data/ready_data_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

enum Language { english, arabic }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// !------------------------------
  List<String> selectedItemValue = []; // Placed
  List<String> selectedItemValue1 = []; // Preparing

  String? selectedLanguage = "English";

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> itemValue = ["Placed", "Preparing", "Ready"];

    return itemValue
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }



// !-------------------------------
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print("Screen Height: $screenHeight");
    print("Screen Width: $screenWidth");

    var ordernum;

    var optionName = AppLocalizations.of(context);

// !-------------------------------

    return Scaffold(
        backgroundColor: AppColors.scolor,
        appBar: AppBar(
          backgroundColor: AppColors.scolor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/image/qd_logo.webp",
              height: 60,
              width: 150,
              fit: BoxFit.fill,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10),
              child: Row(
                children: [
                  const Icon(
                    size: 25,
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 10),
                    child:
                        BlocBuilder<GetUserDetailsCubit, GetUserDetailsState>(
                      builder: (context, state) {
                        if (state is GetUserDetailsSuccessState) {
                          return Text(
                            state.userName,
                            style:
                                const TextStyle(color: AppColors.newTextColor),
                          );
                        }
                        if (state is GetUserDetailsErrorState) {
                          return Text(state.errorName);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  BlocConsumer<LogoutCubit, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutSuccessState) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route route) => false);
                      }
                      if (state is LogoutErrorState) {
                        print("Logout Failed.......");
                      }
                    },
                    builder: (context, state) {
                      return PopupMenuButton(
                          position: PopupMenuPosition.under,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.black,
                            size: 20,
                          ),
                          color: AppColors.newCardBackgroundColor,
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    onTap: () {},
                                    textStyle: const TextStyle(
                                      color: AppColors.newTextColor,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<LogoutCubit>(context)
                                            .logout();
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: AppColors.newTextColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Logout",
                                            style: TextStyle(
                                              color: AppColors.newTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ]);
                    },
                  ),
                  Text(
                    selectedLanguage!,
                    style: const TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 14,
                      fontFamily: CustomLabels.primaryFont,
                    ),
                  ),
                  BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                    builder: (context, state) {
                      return PopupMenuButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColors.iconColor,
                            size: 20,
                          ),
                          onSelected: (Language value) {
                            // selectedLanguage = "$value";
                            if (Language.english.name == value.name) {
                              selectedLanguage = "English";
                              BlocProvider.of<ChangeLanguageCubit>(context)
                                  .ChangelanguageFunction(Locale('en'));

                              print("Selected Language: ${value.name}");
                            } else {
                              selectedLanguage = "عربي";
                              BlocProvider.of<ChangeLanguageCubit>(context)
                                  .ChangelanguageFunction(Locale('ar'));

                              print("Selected Language: ${value.name}");
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<Language>>[
                                const PopupMenuItem(
                                  value: Language.english,
                                  child: Text('English'),
                                ),
                                const PopupMenuItem(
                                  value: Language.arabic,
                                  child: Text('arabic'),
                                ),
                              ]);
                    },
                  )
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //* ------------- Container 1 ---------------
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
                child: SizedBox(
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.placed,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      BlocConsumer<GetDataCubit, GetDataState>(
                        listener: (context, state) {
                          if (state is GetAllDataErrorState) {
                            return OverlayManager.showSnackbar(context,
                                type: ContentType.failure,
                                title: "Failed",
                                message: CustomMessages.loginFailed);
                          }
                        },
                        builder: (context, state) {
                          print(state);

                          if (state is GetPlacedDataLoadedState) {
                            // print("order id${state.orderList[0].items?.length}");
                            return Container(
                              // color: Colors.red,
                              height: screenHeight * 0.30,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.placedList.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    for (int i = 0; i < 3; i++) {
                                      selectedItemValue.add("Placed");
                                    }

                                    var orderdata = state.placedList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: AppColors.newCardBackgroundColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors
                                                  .newCardBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          width: screenWidth * 0.30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      AutoSizeText(
                                                        "${AppLocalizations.of(context)!.orderno}: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                      AutoSizeText(
                                                        orderdata.orderNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    AutoSizeText(
                                                      "${AppLocalizations.of(context)!.tableno}: ",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                      minFontSize: 14,
                                                      maxFontSize: 18,
                                                    ),
                                                    AutoSizeText(
                                                      orderdata.tableNo
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                      minFontSize: 14,
                                                      maxFontSize: 18,
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AutoSizeText(
                                                      orderdata.items![0].name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                      minFontSize: 14,
                                                      maxFontSize: 18,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7.0),
                                                      child: AutoSizeText(
                                                        orderdata
                                                            .items![0].quatity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .newTextColor,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //------- View More --------------

                                                state.placedList[index].items!
                                                            .length >
                                                        1
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            child: AutoSizeText(
                                                              "${AppLocalizations.of(context)!.viewmore} ",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  decorationColor:
                                                                      AppColors
                                                                          .secondaryColor,
                                                                  color: AppColors
                                                                      .secondaryColor,
                                                                  fontSize: 14),
                                                              minFontSize: 12,
                                                              maxFontSize: 14,
                                                            ),
                                                            onTap: () {
                                                              ordernum = orderdata
                                                                  .orderNo
                                                                  .toString();

                                                              showDialog(
                                                                barrierDismissible:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  var screenSize =
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size;
                                                                  return Dialog(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .newCardBackgroundColor,
                                                                    child:
                                                                        SizedBox(
                                                                      width: screenSize
                                                                              .width *
                                                                          0.3, // 80% of screen width
                                                                      height: screenSize
                                                                              .height *
                                                                          0.5, // 50% of screen height

                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppColors.newCardBackgroundColor,
                                                                            borderRadius: BorderRadius.circular(15)),
                                                                        height: screenHeight *
                                                                            0.50,
                                                                        width: screenWidth *
                                                                            0.25,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 20.0,
                                                                              bottom: 8,
                                                                              right: 10,
                                                                              left: 10),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(bottom: 25.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${AppLocalizations.of(context)!.orderno}: ",
                                                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                                                                    ),
                                                                                    Text(
                                                                                      ordernum,
                                                                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  itemCount: orderdata.items!.length,
                                                                                  itemBuilder: (context, index1) {
                                                                                    return Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        AutoSizeText(
                                                                                          orderdata.items![index1].name.toString(),
                                                                                          style: const TextStyle(color: AppColors.newTextColor, fontSize: 18),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(right: 7.0),
                                                                                          child: AutoSizeText(
                                                                                            orderdata.items![index1].quatity.toString(),
                                                                                            style: const TextStyle(color: AppColors.newTextColor, fontSize: 18),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    : Container(),

                                                //--------------------------------

                                                Padding(
                                                  padding: state
                                                              .placedList[index]
                                                              .items!
                                                              .length ==
                                                          1
                                                      ? const EdgeInsets.only(
                                                          top: 26.0,
                                                        )
                                                      : const EdgeInsets.only(
                                                          top: 5.0,
                                                        ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors.scolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0,
                                                              right: 2),
                                                      child: SizedBox(
                                                        child: BlocBuilder<
                                                            CheckStatusCubit,
                                                            CheckStatusState>(
                                                          builder:
                                                              (context, state) {
                                                            return

                                                                 DropdownButtonFormField(
                                                                  decoration: const InputDecoration(
                                                                      enabledBorder:
                                                                          UnderlineInputBorder(
                                                                              borderSide:
                                                                                  BorderSide(color: Colors.transparent))),
                                                                  dropdownColor:
                                                                      Colors.white,
                                                                  value:
                                                                      selectedItemValue[
                                                                          index],
                                                                  items:
                                                                      _dropDownItem(),
                                                                  onChanged:
                                                                      (value) {
                                                                    status =
                                                                        selectedItemValue[
                                                                                index] =
                                                                            value!;

                                                                    id = orderdata
                                                                        .orderId
                                                                        .toString();

                                                                    BlocProvider.of<
                                                                                CheckStatusCubit>(
                                                                            context)
                                                                        .CheckStatusData();

                                                                    BlocProvider.of<
                                                                                GetDataCubit>(
                                                                            context)
                                                                        .fetchPlacedlData();

                                                                    BlocProvider.of<
                                                                                FetchPreparedDataCubit>(
                                                                            context)
                                                                        .fetchPreparedlData();

                                                                    BlocProvider.of<
                                                                                ReadyDataCubit>(
                                                                            context)
                                                                        .readyData();

                                                                    setState(() {
                                                                      print(
                                                                          '<< Placed Selected Index: $index and value: $value >>');
                                                                    });
                                                                  },
                                                                  onTap: () {},
                                                                  // hint: Text('0'),
                                                                );

       


                                                            
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              //* ------------- Container 2 ---------------

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(6, 109, 120, 142),
                          Color(0xff2BA3D3),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              isRepeatingAnimation: true,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                    "${AppLocalizations.of(context)!.preparing}."),
                                TypewriterAnimatedText(
                                    "${AppLocalizations.of(context)!.preparing}.."),
                                TypewriterAnimatedText(
                                    "${AppLocalizations.of(context)!.preparing}..."),
                              ],
                            ),
                          ),
                        ),
                        BlocConsumer<FetchPreparedDataCubit,
                            FetchPreparedDataState>(
                          listener: (context, state) {
                            if (state is GetAllDataErrorState1) {
                              return OverlayManager.showSnackbar(context,
                                  type: ContentType.failure,
                                  title: "Failed",
                                  message: CustomMessages.loginFailed);
                            }
                          },
                          builder: (context, state) {
                            print(state);

                            if (state is GetPreparedDataLoadedState) {
                              return Container(
                                height: screenHeight * 0.30,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.preparedList.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      for (int i = 0; i < 3; i++) {
                                        selectedItemValue1.add("Preparing");
                                      }

                                      var orderdata = state.preparedList[index];
                                      // print(" Order Name: ${orderdata.items![index].name}");

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          color:
                                              AppColors.newCardBackgroundColor,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .newCardBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            width: screenWidth * 0.30,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        AutoSizeText(
                                                          "${AppLocalizations.of(context)!.orderno}: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                          minFontSize: 14,
                                                          maxFontSize: 18,
                                                        ),
                                                        AutoSizeText(
                                                          orderdata.orderNo
                                                              .toString(),
                                                          // state.orderList[index].orderNo.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                          minFontSize: 14,
                                                          maxFontSize: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0,
                                                            bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        AutoSizeText(
                                                          "${AppLocalizations.of(context)!.tableno}: ",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .newTextColor,
                                                              fontSize: 18),
                                                          minFontSize: 14,
                                                          maxFontSize: 18,
                                                        ),
                                                        AutoSizeText(
                                                          orderdata.tableNo
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .newTextColor,
                                                              fontSize: 18),
                                                          minFontSize: 14,
                                                          maxFontSize: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AutoSizeText(
                                                        orderdata.items![0].name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .newTextColor,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 7.0),
                                                        child: AutoSizeText(
                                                          orderdata.items![0]
                                                              .quatity!
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .newTextColor,
                                                              fontSize: 18),
                                                          minFontSize: 14,
                                                          maxFontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //------- View More --------------

                                                  state.preparedList[index]
                                                              .items!.length >
                                                          1
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              child:
                                                                  AutoSizeText(
                                                                "${AppLocalizations.of(context)!.viewmore} ",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    decorationColor:
                                                                        AppColors
                                                                            .secondaryColor,
                                                                    color: AppColors
                                                                        .secondaryColor,
                                                                    fontSize:
                                                                        14),
                                                                minFontSize: 12,
                                                                maxFontSize: 14,
                                                              ),
                                                              onTap: () {
                                                                ordernum = orderdata
                                                                    .orderNo
                                                                    .toString();

                                                                showDialog(
                                                                  barrierDismissible:
                                                                      true,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    var screenSize =
                                                                        MediaQuery.of(context)
                                                                            .size;
                                                                    return Dialog(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .newCardBackgroundColor,
                                                                      child:
                                                                          SizedBox(
                                                                        width: screenSize.width *
                                                                            0.3, // 80% of screen width
                                                                        height: screenSize.height *
                                                                            0.5, // 50% of screen height

                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: AppColors.newCardBackgroundColor,
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          height:
                                                                              screenHeight * 0.50,
                                                                          width:
                                                                              screenWidth * 0.25,
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                top: 20.0,
                                                                                bottom: 8,
                                                                                right: 10,
                                                                                left: 10),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(bottom: 25.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "${AppLocalizations.of(context)!.orderno}: ",
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                                                                      ),
                                                                                      Text(
                                                                                        ordernum,
                                                                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    itemCount: orderdata.items!.length,
                                                                                    itemBuilder: (context, index1) {
                                                                                      return Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          AutoSizeText(
                                                                                            orderdata.items![index1].name.toString(),
                                                                                            style: const TextStyle(color: AppColors.newTextColor, fontSize: 18),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(right: 7.0),
                                                                                            child: AutoSizeText(
                                                                                              orderdata.items![index1].quatity.toString(),
                                                                                              style: const TextStyle(color: AppColors.newTextColor, fontSize: 18),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    }),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      : Container(),

                                                  //--------------------------------

                                                  Padding(
                                                    padding: state
                                                                .preparedList[
                                                                    index]
                                                                .items!
                                                                .length ==
                                                            1
                                                        ? const EdgeInsets.only(
                                                            top: 26.0,
                                                          )
                                                        : const EdgeInsets.only(
                                                            top: 5.0,
                                                          ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.scolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 2.0,
                                                                right: 2),
                                                        child: BlocBuilder<
                                                            CheckStatusCubit,
                                                            CheckStatusState>(
                                                          builder:
                                                              (context, state) {
                                                            return DropdownButtonFormField(
                                                              decoration: const InputDecoration(
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.transparent))),
                                                              dropdownColor:
                                                                  Colors.white,
                                                              value:
                                                                  selectedItemValue1[
                                                                      index],
                                                              items:
                                                                  _dropDownItem(),
                                                              onChanged:
                                                                  (value) {
                                                                status =
                                                                    selectedItemValue1[
                                                                            index] =
                                                                        value!;

                                                                id = orderdata
                                                                    .orderId
                                                                    .toString();

                                                                BlocProvider.of<
                                                                            CheckStatusCubit>(
                                                                        context)
                                                                    .CheckStatusData();

                                                                BlocProvider.of<
                                                                            FetchPreparedDataCubit>(
                                                                        context)
                                                                    .fetchPreparedlData();

                                                                BlocProvider.of<
                                                                            GetDataCubit>(
                                                                        context)
                                                                    .fetchPlacedlData();

                                                                setState(() {
                                                                  print(
                                                                      '<< Placed Selected Index: ${index} and value: ${value} >>');
                                                                });
                                                              },
                                                              onTap: () {},
                                                              // hint: Text('0'),
                                                            );
                                                          },
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
                                    }),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

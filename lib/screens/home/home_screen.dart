import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_task/core/common/colors.dart';
import 'package:kitchen_task/core/common/common_messages.dart';
import 'package:kitchen_task/core/common/overlay.dart';
import 'package:kitchen_task/core/features/auth/cubits/get_user_details/get_user_details_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/logout/logout_cubit.dart';
import 'package:kitchen_task/core/features/auth/presentation/login_screen.dart';
import 'package:kitchen_task/screens/home/common/common_list.dart';
import 'package:kitchen_task/screens/home/cubits/check_status/check_status_cubit.dart';
import 'package:kitchen_task/screens/home/cubits/fetch_preparedData/fetch_prepared_data_cubit.dart';

import 'package:kitchen_task/screens/home/cubits/get_data/get_data_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// ------------------------------
  List<String> selectedItemValue = []; // Placed
  List<String> selectedItemValue1 = []; // Preparing

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> itemValue = ["Placed", "Preparing", "Ready"];

    return itemValue
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

//-------------------------------
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print("Screen Height: $screenHeight");
    print("Screen Width: $screenWidth");

//-------------------------------

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
            padding: EdgeInsets.only(right: 20.0, left: 10),
            child: Row(
              children: [
                Icon(
                  size: 25,
                  Icons.notifications,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0, left: 10),
                  child: BlocBuilder<GetUserDetailsCubit, GetUserDetailsState>(
                    builder: (context, state) {
                      if (state is GetUserDetailsSuccessState) {
                        return Text(
                          state.userName,
                          style: TextStyle(color: AppColors.newTextColor),
                        );
                      }
                      if (state is GetUserDetailsErrorState) {
                        return Text(state.errorName);
                      }
                      return SizedBox();
                    },
                  ),
                ),
                BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state is LogoutSuccessState) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
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
                                    child: Row(
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
                )
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          //------------- Container 1 ---------------
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
            child: SizedBox(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Placed",
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
                          height: screenHeight * 0.28,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.placedList.length,
                              physics: BouncingScrollPhysics(),
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
                                          color:
                                              AppColors.newCardBackgroundColor,
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Order No: ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    orderdata.orderNo
                                                        .toString(),
                                                    // state.orderList[index].orderNo.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, bottom: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Table No: ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .newTextColor,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    orderdata.tableNo
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .newTextColor,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  orderdata.items!.length,
                                              itemBuilder: (context, index1) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AutoSizeText(
                                                      orderdata
                                                          .items![index1].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7.0),
                                                      child: AutoSizeText(
                                                        orderdata.items![index1]
                                                            .quatity
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .newTextColor,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, bottom: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.scolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0, right: 2),
                                                  child: SizedBox(
                                                    child: BlocBuilder<
                                                        CheckStatusCubit,
                                                        CheckStatusState>(
                                                      builder:
                                                          (context, state) {
                                                        return DropdownButtonFormField(
                                                          decoration: InputDecoration(
                                                              enabledBorder: UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.white))),
                                                          dropdownColor:
                                                              Colors.white,
                                                          value:
                                                              selectedItemValue[
                                                                  index],
                                                          items:
                                                              _dropDownItem(),
                                                          onChanged: (value) {
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

          //------------- Container 2 ---------------

          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(6, 109, 120, 142),
                      const Color(0xff2BA3D3),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            TypewriterAnimatedText('Preparing.'),
                            TypewriterAnimatedText('Preparing..'),
                            TypewriterAnimatedText('Preparing...'),
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
                            height: screenHeight * 0.28,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.preparedList.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  for (int i = 0; i < 3; i++) {
                                    selectedItemValue1.add("Preparing");
                                  }

                                  var orderdata = state.preparedList[index];
                                  // print(" Order Name: ${orderdata.items![index].name}");

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
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Order No: ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      orderdata.orderNo
                                                          .toString(),
                                                      // state.orderList[index].orderNo.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Table No: ",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      orderdata.tableNo
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    orderdata.items!.length,
                                                itemBuilder: (context, index1) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        orderdata
                                                            .items![index1].name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .newTextColor,
                                                            fontSize: 18),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 7.0),
                                                        child: Text(
                                                          orderdata
                                                              .items![index1]
                                                              .quatity!
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .newTextColor,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.scolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
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
                                                          return DropdownButtonFormField(
                                                            decoration: InputDecoration(
                                                                enabledBorder: UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.white))),
                                                            dropdownColor:
                                                                Colors.white,
                                                            value:
                                                                selectedItemValue1[
                                                                    index],
                                                            items:
                                                                _dropDownItem(),
                                                            onChanged: (value) {
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
    );
  }
}

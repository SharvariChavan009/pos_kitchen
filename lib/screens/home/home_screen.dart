import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_task/core/common/colors.dart';
import 'package:kitchen_task/core/common/common_messages.dart';
import 'package:kitchen_task/core/common/overlay.dart';
import 'package:kitchen_task/screens/home/cubits/get_data/get_data_cubit.dart';
import 'package:kitchen_task/screens/home/model/order_model.dart';

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              size: 30,
              Icons.notifications,
              color: Colors.black,
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
                  SizedBox(
                    height: screenHeight * 0.28,
                    child: BlocConsumer<GetDataCubit, GetDataState>(
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

                        if (state is GetAllDataLoadedState) {
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.data.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                for (int i = 0; i < 3; i++) {
                                  selectedItemValue.add("Placed");
                                }

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
                                                    "#00026",
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
                                                    "3",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .newTextColor,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Mango Shake",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .newTextColor,
                                                      fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7.0),
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .newTextColor,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
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
                                                          left: 2.0, right: 2),
                                                  child: SizedBox(
                                                    width: 300,
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration: InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.white))),
                                                      dropdownColor:
                                                          Colors.white,
                                                      value: selectedItemValue[
                                                          index],
                                                      items: _dropDownItem(),
                                                      onChanged: (value) {
                                                        selectedItemValue[
                                                            index] = value!;

                                                        setState(() {
                                                          print(
                                                              '<< Placed Selected Index: ${index} and value: ${value} >>');
                                                        });
                                                      },
                                                      // hint: Text('0'),
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
                              });
                        } else {
                          return Container();
                        }
                      },
                    ),
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
                    SizedBox(
                      height: screenHeight * 0.28,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            for (int i = 0; i < 3; i++) {
                              selectedItemValue1.add("Preparing");
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: AppColors.newCardBackgroundColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.newCardBackgroundColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: screenWidth * 0.30,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Order No: ",
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                "#00026",
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
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
                                                    color:
                                                        AppColors.newTextColor,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                "3",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.newTextColor,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Mango Shake",
                                              style: TextStyle(
                                                color: AppColors.newTextColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 7.0),
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.newTextColor,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.scolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0, right: 2),
                                              child: SizedBox(
                                                width: 300,
                                                child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white))),
                                                  dropdownColor: Colors.white,
                                                  value:
                                                      selectedItemValue1[index],
                                                  items: _dropDownItem(),
                                                  onChanged: (value) {
                                                    selectedItemValue1[index] =
                                                        value!;

                                                    setState(() {
                                                      print(
                                                          '<< Preparing Selected Index: ${index} and value: ${value} >>');
                                                    });
                                                  },
                                                  // hint: Text('0'),
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

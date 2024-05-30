import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_task/core/common/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// ------------------------------
  List<String> items = ["Placed", "Preparing", "Ready"];

  List<String> selectedValuesPlaced = [];
  List<String> selectedValuesPrepare = [];

//-------------------------------
  @override
  Widget build(BuildContext context) {
    // ------------------------------

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
            padding: const EdgeInsets.all(10.0),
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Order No: ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "#00026",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
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
                                                color: AppColors.newTextColor,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "3",
                                            style: TextStyle(
                                                color: AppColors.newTextColor,
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
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7.0),
                                          child: Text(
                                            "1",
                                            style: TextStyle(
                                                color: AppColors.newTextColor,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.scolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2.0, right: 2),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white))),
                                            dropdownColor: Colors.white,
                                            style: TextStyle(
                                                color: AppColors.newTextColor,
                                                fontSize: 18),
                                            value: selectedValuesPlaced.length >
                                                    index
                                                ? selectedValuesPlaced[index]
                                                : "Placed",
                                            items: items.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedValuesPlaced.length =
                                                    index + 1;
                                                selectedValuesPlaced[index] =
                                                    newValue!;
                                              });
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
                ),
              ],
            ),
          ),

          //------------- Container 2 ---------------

          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
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
                    // Text(
                    //   "Preparing",
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 20),
                    // ),
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
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
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
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white))),
                                                dropdownColor: Colors.white,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.newTextColor,
                                                    fontSize: 18),
                                                value: selectedValuesPrepare
                                                            .length >
                                                        index
                                                    ? selectedValuesPrepare[
                                                        index]
                                                    : "Preparing",
                                                items:
                                                    items.map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValuesPlaced
                                                        .length = index + 1;
                                                    selectedValuesPlaced[
                                                        index] = newValue!;
                                                  });
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

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_task/images/image.dart';
import '../../core/common/colors.dart';
import '../../core/common/label.dart';
import '../../core/features/auth/cubits/change_language/change_language_cubit.dart';
import '../../core/features/auth/cubits/get_user_details/get_user_details_cubit.dart';
import '../../core/features/auth/cubits/logout/logout_cubit.dart';
import '../../core/features/auth/presentation/login_screen.dart';
import 'common/common_list.dart';
import 'cubits/check_status/check_status_cubit.dart';
import 'cubits/fetch_preparedData/fetch_prepared_data_cubit.dart';
import 'cubits/get_data/get_data_cubit.dart';
import 'model/order_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

String? selectedLanguage = "English";
enum Language { english, arabic }

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.scolor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppImage.mainLogo,
              height: 50,
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
                          position: PopupMenuPosition.over,
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
                                  child: Text('Arabic'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TypewriterAnimatedText("${optionName!.placed}."),
                      TypewriterAnimatedText("${optionName!.placed}.."),
                      TypewriterAnimatedText("${optionName!.placed}..."),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.whiteColor,
                width: double.infinity,
                child: Expanded(child: BlocBuilder<GetDataCubit, GetDataState>(
                  builder: (context, state) {
                    if (state is GetPlacedDataLoadedState) {
                      print("placed list count = ${state.placedList.length}");
                      orders1 = state.placedList;
                    }
                    return Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: orders1
                                  .map((order) => OrderCard(order: order))
                                  .toList(),
                            )));
                  },
                )),
              ),
              Container(
                  color: AppColors.darkColor,
                  child: Text(
                    "${optionName!.preparing}........",
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              BlocBuilder<FetchPreparedDataCubit, FetchPreparedDataState>(
                builder: (context, state) {
                  if (state is GetPreparedDataLoadedState) {
                    print("list count =${state.preparedList.length}");
                    orders2 = state.preparedList;
                  }
                  return Container(
                    color: AppColors.whiteColor,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orders2
                            .map((order) => OrderCard(order: order))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> itemValue = ["Placed", "Preparing", "Ready"];

  return itemValue
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

List<DropdownMenuItem<String>> _dropDownItemArabic() {
  List<String> itemValue = ["تم وضعه", "خطة", "مستعد"];

  return itemValue
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

List<String> selectedItemValue = []; // ready

class OrderCard extends StatelessWidget {
  final OrderModel order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);

    return Card(
      elevation: 10.0,
      shadowColor: (order.status == "Placed") ? AppColors.buttonColor : AppColors.darkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      child: Container(
        width: 300, // Adjust the width as needed
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText(
                  "${optionName!.orderno}: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  order.orderId.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
              ],
            ),
            Row(
              children: [
                AutoSizeText(
                  "${optionName!.tableno}: ",
                  style: const TextStyle(
                    color: AppColors.newTextColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  order.tableNo.toString(),
                  style: const TextStyle(
                    color: AppColors.newTextColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
              ],
            ),
            AutoSizeText(
              "${optionName!.orderItems}: ",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              minFontSize: 14,
              maxFontSize: 18,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.items!.length,
              itemBuilder: (BuildContext context, int index) {
                final item = order.items![index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item!.name!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: Text(
                        item!.quatity!.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
              builder: (context, state) {
                Locale name = Locale("en");
                if (state is ChangeLanguageSuccess) {
                  print("labguagauge =${state.name}");
                  name = state.name!;
                }

                  return DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    value: status,
                    items: (name ==  Locale('ar')) ? _dropDownItemArabic() : _dropDownItem(),
                    onChanged: (value) {
                      print(value);
                      status = value!;

                      id = order.orderId.toString();

                      BlocProvider.of<CheckStatusCubit>(context)
                          .CheckStatusData();

                      BlocProvider.of<FetchPreparedDataCubit>(context)
                          .fetchPreparedlData();

                      BlocProvider.of<GetDataCubit>(context).fetchPlacedlData();
                    },
                    onTap: () {},
                  );
                }



        ),
      ]
        ),
    )
    );
  }
}

List<OrderModel> orders1 = [];
List<OrderModel> orders2 = [];

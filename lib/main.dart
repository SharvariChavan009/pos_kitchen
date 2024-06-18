import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:kitchen_task/core/features/auth/cubits/CheckEmailPassword/check_email_pass_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/change_language/change_language_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/email/email_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/get_user_details/get_user_details_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/logout/logout_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/password/login_cubit.dart';
import 'package:kitchen_task/core/features/auth/presentation/login_screen.dart';
import 'package:kitchen_task/core/features/splash_screen/splash_screen.dart';
import 'package:kitchen_task/screens/home/cubits/check_status/check_status_cubit.dart';
import 'package:kitchen_task/screens/home/cubits/fetch_preparedData/fetch_prepared_data_cubit.dart';
import 'package:kitchen_task/screens/home/cubits/get_data/get_data_cubit.dart';
import 'package:kitchen_task/screens/home/cubits/ready_data/ready_data_cubit.dart';
import 'package:kitchen_task/screens/home/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => EmailCubit()),
          BlocProvider(create: (context) => CheckEmailPassCubit()),
          BlocProvider(create: (context) => GetDataCubit()),
          BlocProvider(create: (context) => CheckStatusCubit()),
          BlocProvider(create: (context) => FetchPreparedDataCubit()),
          BlocProvider(create: (context) => GetUserDetailsCubit()),
          BlocProvider(create: (context) => LogoutCubit()),
          BlocProvider(create: (context) => ReadyDataCubit()),
          BlocProvider(create: (context) => ChangeLanguageCubit()),
        ],
        child:
            // MaterialApp(
            //   title: 'Kitchen Screen',
            //   debugShowCheckedModeBanner: false,
            //   theme: ThemeData(
            //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //     useMaterial3: true,
            //   ),
            //   home: const SplashScreen(),

            // ),

            
            BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
          builder: (context, state) {
            Locale? languageName;
            if (state is ChangeLanguageSuccess) {
              languageName = state.name;
              print(
                  "languagage name =${languageName},code=${languageName!.languageCode}");
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Kitcen Applications',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SplashScreen(),
              locale: languageName,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );
          },
        ));
  }
}

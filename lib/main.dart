import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kitchen_task/core/features/auth/cubits/CheckEmailPassword/check_email_pass_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/email/email_cubit.dart';
import 'package:kitchen_task/core/features/auth/cubits/password/login_cubit.dart';
import 'package:kitchen_task/core/features/auth/presentation/login_screen.dart';
import 'package:kitchen_task/screens/home/cubits/get_data/get_data_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
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



      ],
      child: MaterialApp(
        title: 'Home Screen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_task/core/common/colors.dart';
import 'package:kitchen_task/core/common/label.dart';
import 'package:kitchen_task/core/features/auth/presentation/login_screen.dart';
import 'package:kitchen_task/images/image.dart';
import 'package:fade_out_particle/fade_out_particle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
      void initState() {
      super.initState();
      Timer(
          const Duration(seconds: 4),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  @override
  Widget build(BuildContext context) {
  

    bool isLogoVisible = true;

    Widget getAnimationContainer({bool isImageSet = true}) {
      return LayoutBuilder(
        builder: (context, size) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                height:
                    isImageSet ? 550 : MediaQuery.of(context).size.height / 1.5,
                width: isImageSet ? 550 : 250,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(seconds: 1),
                top: isImageSet ? size.maxHeight : 20,
                child: Image.asset(
                  AppImage.logo1,
                  height: 300,
                  width: 500,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const FadeOutParticle(
                curve: Easing.emphasizedAccelerate,
                disappear: true,
                duration: Duration(milliseconds: 4000),
                child: AutoSizeText(
                  'Empowering Your Culinary Journey',
                  minFontSize: 25,
                  maxFontSize: 30,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    decorationColor: AppColors.whiteColor,
                    fontSize: 30,
                    fontWeight: CustomLabels.largeFontWeight,
                    fontFamily: CustomLabels.secondaryFont,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImage.splash,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: 'Logo',
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 2),
                    // ignore: dead_code
                    opacity: isLogoVisible ? 1.0 : 1.0,
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: getAnimationContainer(isImageSet: isLogoVisible),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

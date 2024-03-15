import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/pages/login_page.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: AnimatedSplashScreen(
        duration: 3300,
        splash: Center(
            child: Lottie.asset('assets/animation.json'),
        ),
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: 400,
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
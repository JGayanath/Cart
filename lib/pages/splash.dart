
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/pages/home.dart';

class Splash_Screen extends StatelessWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    )); //statusbar color change

    return
      Scaffold(
        body: AnimatedSplashScreen(
          backgroundColor: Colors.white,
            duration: 1500,
            splash: Image.asset("assets/images/Pay_drow.png",
            ),
            splashIconSize: MediaQuery.of(context).size.width*0.5,
            nextScreen: Pree_Bill(),
            splashTransition: SplashTransition.fadeTransition,
        ),
      );
  }
}

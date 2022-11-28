import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/screens/home.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:sizer/sizer.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Utils_Functions.navigatePush(context, Pree_Bill());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
                duration: Duration(seconds: 3),
                child: Image.asset(
                  "assets/images/Pay_drow.png",
                  width: 50.w,
                  height: 50.h,
                )),
            FadeInDown(
              duration: Duration(seconds: 3),
              child: Text(
                "Pree Bill",
                style: TextStyle(fontSize: 35.sp, color: AppColors.appColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
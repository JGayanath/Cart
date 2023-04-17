
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pree_bill/screens/main_screen.dart';
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
      Utils_Functions.navigatePush(context, Main_Screen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                "assets/images/shop.json",
                fit: BoxFit.fill,
                height: 50.h,
                width: 80.w,
              ),
            ),
            Text(
              "Cart",
              style: TextStyle(fontSize: 25.sp, color:AppColors.appColor,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/screens/home.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/assets_image.dart';
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
      statusBarColor: AppColors.appColor,
    ));

    return Scaffold(
      backgroundColor:AppColors.appColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(10.w),
                width: 75.w,
                height: 60.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor.withOpacity(0.9),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Color(0xffFFFFFF).withOpacity(0.6),
                  //       spreadRadius: 10.sp,
                  //       blurRadius: 10.0,
                  //       offset: Offset(3.0, 3.0)),
                  // ],
                ),
                child: FadeInRight(
                  child: Image.asset(Assets_Image.cartProfile),
                  delay: Duration(milliseconds: 1500),
                ),
              ),
            ),
            Text(
              "Cart",
              style: TextStyle(fontSize: 35.sp, color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:sizer/sizer.dart';

class Custom_Drawer extends StatelessWidget {
  const Custom_Drawer({
    required this.currency_select(),
    Key? key,
  }) : super(key: key);

  final Function() currency_select;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.appColor, // set status bar color
      ),
    );
    return Container(
      width: 80.w,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(180, 250, 250, 250),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(31, 38, 135, 0.4),
              blurRadius: 8.0.w,
            )
          ],
      ),
      child: Column(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                  AppColors.appColor.withOpacity(0.0),
                  Colors.white.withOpacity(0.2),
                ])),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: DrawerHeader(
              padding : EdgeInsets.symmetric(vertical: 15.sp , horizontal: 10.sp ),
              decoration: BoxDecoration(
                color: AppColors.appColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:5,
                    child: Container(
                        padding: EdgeInsets.all(10.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.whiteColor.withOpacity(0.8),
                                spreadRadius: 8.5,
                                blurRadius: 10.0,
                                offset: Offset(3.0, 3.0)),
                          ],
                        ),
                        child: Lottie.asset(
                          "assets/images/shop.json",fit: BoxFit.fill,)),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Custom_Text(
                        text: "Cart",
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
            ),
          ),
          Expanded(
            flex: 14,
            child: Column(
              children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.currency_exchange,
                        color: AppColors.appColor,
                        size: 18.0.sp,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Custom_Text(
                        text: "Change Currency",
                        fontSize: 12.sp,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                  onTap: () {
                    currency_select();
                    Utils_Functions.navigatePop(context);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                ),
              ),
                Expanded(
                  flex: 1,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppColors.appColor,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Custom_Text(
                        text: "About",
                        fontSize: 12.0.sp,
                        color: AppColors.blackColor,
                      )
                    ],
                  ),
                  onTap: () {
                    AwesomeDialog(
                      btnOkText: "Ok",
                      btnOkColor: AppColors.appColor,
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.info,
                      body: Container(
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "This app is useful for bill calculation while purchasing goods.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,),
                        ),
                      ),
                      btnOkOnPress: () {
                        Utils_Functions.navigatePop(context);
                      },
                    ).show();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                ),
              ),
                Expanded(
                  flex: 1,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.contact_support,
                        color: AppColors.appColor,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Custom_Text(
                        text: "Contact Us",
                        fontSize: 12.0.sp,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                  onTap: () {
                    AwesomeDialog(
                      btnOkText: "Ok",
                      btnOkColor: AppColors.appColor,
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.info,
                      body: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "janakagayanath@gmail.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,),
                        ),
                      ),
                      btnOkOnPress: () {
                        Utils_Functions.navigatePop(context);
                      },
                    ).show();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                ),
              ),
                Expanded(
                  flex: 1,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: AppColors.appColor,
                        size: 18.0.sp,
                      ),
                      SizedBox(
                        width: 7.0.w,
                      ),
                      Custom_Text(
                        text: "Home",
                        fontSize: 12.sp,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Expanded(
                flex: 1,
                child: SizedBox(
                ),
              ),
                Expanded(
                  flex: 1,
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: AppColors.appColor,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Custom_Text(
                        text: "Exit",
                        fontSize: 12.0.sp,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                  onTap: () {
                    Utils_Functions.showMyDialog(
                        context,
                        "Exit",
                        "Cancel",
                        "Do you want to close this app?",
                        DialogType.warning,
                            () {
                          Utils_Functions.exitApp();
                        },
                            () => Utils_Functions.navigatePop(context));
                  },
                ),
              ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
            ],
          ),)
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class Utils_Functions {

  static void navigatePush(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
  static Future<void> showMyDialog(BuildContext context, String btnOkText,String btnCancelText,
      String text, DialogType dialogType, Function() btnOkOnpress,Function() btnCancelOnpress) async {
    return AwesomeDialog(
      btnCancelColor: AppColors.redColor,
      btnOkText: btnOkText,
      btnCancelText: btnCancelText,
      btnOkColor: AppColors.appColor,
      context: context,
      animType: AnimType.scale,
      dialogType: dialogType,
      body: Container(
        padding: EdgeInsets.all(10.sp),
        child: Text(
        "${text}",
          textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.sp,
        fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ),
      btnCancelOnPress: () {
        btnCancelOnpress();
      },
      btnOkOnPress: () {
        btnOkOnpress();
      },
    ).show();
  }
  // toast msg
  static void toast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.appColor,
        textColor: AppColors.whiteColor,
        fontSize: 12.0.sp);
  }

  // exit app
  static void exitApp(){
    exit(0);
  }
}

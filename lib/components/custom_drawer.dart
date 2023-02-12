import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/assets_image.dart';
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
          border: Border(
              right: BorderSide(
            color: Colors.white,
          ))),
      child: Stack(
        children: [
          SizedBox(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    AppColors.appColor.withOpacity(0.0),
                    Colors.white.withOpacity(0.2),
                  ])),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 30.h,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.appColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                          width: 30.w,
                          height: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFFFFFF).withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffFFFFFF).withOpacity(0.8),
                                  spreadRadius: 8.5,
                                  blurRadius: 10.0,
                                  offset: Offset(3.0, 3.0)),
                            ],
                          ),
                          child: Image.asset(Assets_Image.cartProfile)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Custom_Text(
                          text: "Cart",
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 4.0.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.currency_exchange,
                          color: AppColors.appColor,
                          size: 22.0.sp,
                        ),
                        SizedBox(
                          width: 7.0.w,
                        ),
                        Custom_Text(
                          text: "Change Currency",
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    onTap: () {
                      currency_select();
                      Utils_Functions.navigatePop(context);
                    },
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: AppColors.appColor,
                          size: 22.0.sp,
                        ),
                        SizedBox(
                          width: 7.0.w,
                        ),
                        Custom_Text(
                          text: "Home",
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: AppColors.appColor,
                          size: 22.sp,
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Custom_Text(
                          text: "About",
                          fontSize: 18.0.sp,
                          color: Colors.black,
                        )
                      ],
                    ),
                    onTap: () {
                      AwesomeDialog(
                        btnOkText: "Ok",
                        btnOkColor: Colors.indigoAccent[700],
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
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        btnOkOnPress: () {
                          Utils_Functions.navigatePop(context);
                        },
                      ).show();
                    },
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.contact_support,
                          color: AppColors.appColor,
                          size: 22.sp,
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Custom_Text(
                          text: "Contact Us",
                          fontSize: 18.0.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    onTap: () {
                      AwesomeDialog(
                        btnOkText: "Ok",
                        btnOkColor: Colors.indigoAccent[700],
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
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        btnOkOnPress: () {
                          Utils_Functions.navigatePop(context);
                        },
                      ).show();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

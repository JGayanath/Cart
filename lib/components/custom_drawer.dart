import 'dart:ui';

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
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                          Assets_Image.droaweImage),
                      radius: 12.w,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Custom_Text(
                        text: "Pree Bill",
                        fontSize: 25.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 7.0.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.currency_exchange,
                          color: AppColors.appColor,
                          size: 30.0.sp,
                        ),
                        SizedBox(
                          width: 7.0.w,
                        ),
                        Custom_Text(
                            text: "Change Currency",
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                          size: 30.0.sp,
                        ),
                        SizedBox(
                          width: 7.0.w,
                        ),
                        Custom_Text(
                            text: "Home",
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Custom_Text(
                            text: "About",
                            fontSize: 20.0.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    onTap: () {
                      //Navigator.pop(context);
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

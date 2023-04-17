
import 'package:flutter/material.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class Custom_TextFieldTotal extends StatelessWidget {
   Custom_TextFieldTotal({
    Key? key, required this.controller,
  }) : super(key: key);


  TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: controller,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0.sp,
        color: AppColors.appColor,
          fontWeight: FontWeight
              .bold
      ),
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
        isCollapsed: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.whiteColor,),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.whiteColor,),
          borderRadius:
          BorderRadius.circular(25.7.w),//------------------------------------------------------------------------------------------------
        ),
      ),
    );
  }
}
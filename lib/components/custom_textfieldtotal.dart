
import 'package:flutter/material.dart';
import 'package:pree_bill/model/provider_model/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:provider/provider.dart';
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
        fontSize: 22.0.sp,
        color: AppColors.appColor,
          fontWeight: FontWeight
              .bold
      ),
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
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
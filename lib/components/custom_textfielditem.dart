

import 'package:flutter/material.dart';
import 'package:pree_bill/model/provider/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Custom_TextFieldItem extends StatelessWidget {
  const Custom_TextFieldItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // select item change
      onChanged: (_) => Provider.of<Cart_Provider>(
          context,
          listen: false)
          .onTextChanged(),
      autocorrect: true,
      onTap: () {
        Provider.of<Cart_Provider>(
            context,
            listen: false)
            .itemController
            .selection = TextSelection(
          baseOffset: 0,
          extentOffset: Provider.of<Cart_Provider>(
              context,
              listen: false)
              .itemController
              .text
              .length,
        );
      },
      controller: Provider.of<Cart_Provider>(
          context,
          listen: false)
          .itemController,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12.0.sp,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isCollapsed: true,
        hintStyle: TextStyle(fontSize: 12.sp),
        hintText: "Name",
        focusedBorder:  OutlineInputBorder(
          borderSide:  BorderSide(
            color: AppColors.whiteColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:  BorderSide(
            color: AppColors.whiteColor,
          ),
          borderRadius: BorderRadius.circular(25.7
              .w), //------------------------------------------------------------------------------------------------
        ),
        //labelText: "Total",
        labelStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold),
        //label style
        //Icon(null),
        floatingLabelBehavior:
        FloatingLabelBehavior.always,
      ),
    );
  }
}

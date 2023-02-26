

import 'package:flutter/material.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class Custom_CollectButton extends StatelessWidget {
  Custom_CollectButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(50.0.w),
        ),
        child: Align(
          alignment: Alignment.center,
            child: Text("Add to cart",style: TextStyle(fontSize: 20.0.sp,color: AppColors.whiteColor,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}

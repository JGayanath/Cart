

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
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.appColor,
                borderRadius: BorderRadius.circular(25.sp),
              ),
              child: Center(child: Text("Add to cart",style: TextStyle(fontSize: 13.0.sp,color: AppColors.whiteColor),)),
            ),
          ),
        ],
      ),
    );
  }
}

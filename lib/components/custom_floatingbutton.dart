
import 'package:flutter/material.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class Custom_FloatingButton extends StatelessWidget {
  Custom_FloatingButton({
    required this.icon,
    required this.onPressed(),
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15.w,
      height: 10.h,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            onPressed();
          },
          child: Center(child: icon),
          backgroundColor: AppColors.appColor,
        ),
      ),
    );
  }
}
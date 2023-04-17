
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class Custom_FloatingButton extends StatefulWidget {
  Custom_FloatingButton({
    required this.icon,
    required this.onPressed(),
    required this.heroTag,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final Function() onPressed;
  final String heroTag;

  @override
  State<Custom_FloatingButton> createState() => _Custom_FloatingButtonState();

}
class _Custom_FloatingButtonState extends State<Custom_FloatingButton> {

  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12.w,
      height: 10.h,
      child: FittedBox(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            print('down');
            timer = Timer.periodic(Duration(milliseconds: 200), (t) {
              setState(() {
                widget.onPressed();
              });
            });
          },
          onTapUp: (TapUpDetails details) {
            timer.cancel();
          },
          onTapCancel: () {
            timer.cancel();
          },
          child: FloatingActionButton(
            heroTag: widget.heroTag,
            onPressed: () {
             widget.onPressed();
            },
            child: Center(child: widget.icon),
            backgroundColor: AppColors.appColor,
          ),
        ),
      ),
    );
  }
}
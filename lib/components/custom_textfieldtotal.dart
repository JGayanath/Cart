
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Custom_TextFieldTotal extends StatelessWidget {
  const Custom_TextFieldTotal({
    Key? key,
    required this.item_Total,
  }) : super(key: key);

  final TextEditingController item_Total;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: item_Total,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22.0.sp,
        color: Colors.black,
          fontWeight: FontWeight
              .bold
      ),
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.white),
          borderRadius:
          BorderRadius.circular(25.7.w),//------------------------------------------------------------------------------------------------
        ),
      ),
    );
  }
}
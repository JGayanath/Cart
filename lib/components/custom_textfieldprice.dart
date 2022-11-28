
import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:sizer/sizer.dart';

class Custom_TextFieldPrice extends StatelessWidget {
  const Custom_TextFieldPrice({
    Key? key,
    required this.item_Price,
  }) : super(key: key);

  final TextEditingController item_Price;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        NumberTextInputFormatter(
          integerDigits: 10,
          decimalDigits: 2,
          maxValue: '1000000000.00',
          decimalSeparator: '.',
          allowNegative: false,
          overrideDecimalPoint: true,
          insertDecimalPoint: true,
          insertDecimalDigits: true,
        )
      ],
      controller: item_Price,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.sp,
      ),
      keyboardType: TextInputType.number,
      cursorColor: Colors.indigoAccent[700],
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
          const BorderSide(color: Colors.white),
          borderRadius:
          BorderRadius.circular(25.7.w),//----------------------------------------------------------------------------------
        ),
        //labelText: 'Price',
        labelStyle: TextStyle(
            fontSize: 25.sp,
            color: Colors.black,
            fontWeight: FontWeight
                .bold),
        //label style//Icon(null),
        floatingLabelBehavior:
        FloatingLabelBehavior.always,
        hintText: "Your Price",
      ),
    );
  }
}
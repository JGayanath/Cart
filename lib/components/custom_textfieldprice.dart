
import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:pree_bill/model/provider_model/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Custom_TextFieldPrice extends StatelessWidget {
  const Custom_TextFieldPrice({
    Key? key,
    required this.function
  }) : super(key: key);

  final Function() function;
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
      controller: Provider.of<CartModelProvider>(context,listen: false).priceController,
      onChanged: (_) => function(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15.sp,
      ),
      keyboardType: TextInputType.number,
      cursorColor: AppColors.appColor,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.whiteColor,),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
          const BorderSide(color: AppColors.whiteColor,),
          borderRadius:
          BorderRadius.circular(25.7.w),//----------------------------------------------------------------------------------
        ),
        //labelText: 'Price',
        labelStyle: TextStyle(
            fontSize: 15.sp,
            color: AppColors.blackColor,
            ),
        //label style//Icon(null),
        floatingLabelBehavior:
        FloatingLabelBehavior.always,
        hintText: "Price",
      ),
    );
  }
}
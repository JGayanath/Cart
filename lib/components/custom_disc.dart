
import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:pree_bill/model/provider_model/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Custom_Disc extends StatefulWidget {
  const Custom_Disc({
    Key? key,
  }) : super(key: key);
  @override
  State<Custom_Disc> createState() => _Custom_DiscState();
}

class _Custom_DiscState extends State<Custom_Disc> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        NumberTextInputFormatter(
          integerDigits: 10,
          decimalDigits: 1,
          maxValue: '1000000000.0',
          decimalSeparator: '.',
          allowNegative: false,
          overrideDecimalPoint: true,
          insertDecimalPoint: true,
          insertDecimalDigits: true,
        )
      ],
      controller: Provider.of<CartModelProvider>(context,listen: false).discountController,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15.sp,
      ),
      keyboardType: TextInputType.datetime,
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
        hintText: "Discount %",
      ),
    );
  }
}
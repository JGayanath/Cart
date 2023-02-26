import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/model/provider_model/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Price_List extends StatefulWidget {
  @override
  State<Price_List> createState() => _Price_ListState();
}

class _Price_ListState extends State<Price_List> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.whiteColor,
    ));

    Provider.of<CartModelProvider>(context).currency_assign();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          title: Text(
            'Cart items',
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 25.0.sp,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Utils_Functions.navigatePop(context);
            },
            icon: Icon(
              Icons.navigate_before_outlined,
              color: AppColors.blackColor,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.home,
                    color: AppColors.appColor,
                    size: 25.0.sp,
                  )),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Utils_Functions.showMyDialog(
                        context,
                        "Ok",
                        "Home",
                        "Total Price:  ${Provider.of<CartModelProvider>(context).currency_homepage + " " + Provider.of<CartModelProvider>(context, listen: false).sumTotal.toStringAsFixed(2)}",
                        DialogType.info,
                        () => Navigator.of(context),
                        () => Utils_Functions.navigatePop(context));
                  },
                  icon: Icon(
                    Icons.info,
                    color: AppColors.appColor,
                    size: 25.0.sp,
                  )),
              label: "",
            ),
          ],
        ),
        body: Consumer<CartModelProvider>(builder: (context , value , child){
          return Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
              child: ListView.builder(
                itemCount: value.input_items.length,
                itemBuilder: (BuildContext ctx, index) => Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0.w)),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius:
                        BorderRadius.circular(8.w), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.shade100
                                .withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                      //color: Colors.white,
                      child: ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.appColor),
                                  '${index + 1}',
                                ),
                                SizedBox(width: 3.0.w),
                                Text(
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.appColor),
                                  '${value.input_items[index]}',
                                ),
                              ],
                            ),
                            SizedBox(height: 2.0.h),
                            Row(
                              children: [
                                Container(
                                  width: 15.w,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Price",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,),
                                      )),
                                ),
                                //SizedBox(width: 1.0.w),
                                Container(
                                  width: 60.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Provider.of<CartModelProvider>(context).currency_homepage +
                                          " : " +
                                          value.input_Price[index],
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Container(
                                  width: 15.w,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Disc",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,),
                                      )),
                                ),
                                SizedBox(width: 1.0.w),
                                Container(
                                  width: 60.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${value.itemDiscounts[index]}  %",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 15.w,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Qty:",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,),
                                      )),
                                ),
                                SizedBox(width: 1.0.w),
                                Container(
                                  width: 40.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,),
                                      '${value.input_Quantity[index]}',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0.w),
                                Container(
                                  width: 20.w,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.w,
                                            color:
                                            AppColors.appColor),
                                        shape: BoxShape.circle,
                                        color: AppColors.whiteColor,
                                      ),
                                      child: IconButton(
                                          icon: Icon(Icons.delete,
                                              size: 15.sp,
                                              color: AppColors.redColor),
                                          onPressed: () {
                                            Utils_Functions.showMyDialog(
                                                context,
                                                "Remove",
                                                "Cancel",
                                                "Do you want to deduction this item?",
                                                DialogType.warning,
                                                    () => Provider.of<
                                                    CartModelProvider>(
                                                    context,
                                                    listen: false)
                                                    .item_Delete(index),
                                                    () => Navigator.of(context));
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 15.w,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                SizedBox(width: 1.w),
                                Container(
                                  width: 60.w,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Provider.of<CartModelProvider>(context).currency_homepage +
                                          " : " +
                                          value.input_Total[index],
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

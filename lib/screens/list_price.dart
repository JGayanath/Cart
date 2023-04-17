import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/model/provider/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Price_List extends StatefulWidget {
  @override
  State<Price_List> createState() => _Price_ListState();
}

class _Price_ListState extends State<Price_List> {
  @override
  Widget build(BuildContext context) {
    //statusBar color change
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.whiteColor,
    ));

    return WillPopScope(
      onWillPop: () async {
        // This will exit the app instead of going back to the previous screen
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            title: Text(
              'Cart items',
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Provider.of<Cart_Provider>(context, listen: false)
                    .listItemsClear(context);
              },
              icon: Icon(
                Icons.clear_all,
                size: 20.sp,
                color: AppColors.blackColor,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    (Provider.of<Cart_Provider>(context, listen: false)
                                .carts
                                .length ==
                            0)
                        ? AwesomeDialog(
                            btnOkText: "Ok",
                            btnOkColor: AppColors.appColor,
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            body: Container(
                              padding: EdgeInsets.all(10.sp),
                              child: Text(
                                "There are not cart items to save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            btnOkOnPress: () {
                              Navigator.of(context);
                            },
                          ).show()
                        : AwesomeDialog(
                            btnOkText: "Ok",
                            btnCancelText: "Cancel",
                            btnOkColor: AppColors.appColor,
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.success,
                            body: Container(
                              padding: EdgeInsets.all(10.sp),
                              child: Provider.of<Cart_Provider>(context,
                                              listen: false)
                                          .carts
                                          .length ==
                                      1
                                  ? Text(
                                      "Do you want to save this is the item?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "Do you want to save these are all items?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            btnCancelOnPress: () {
                              Navigator.of(context);
                            },
                            btnOkOnPress: () {
                              Provider.of<Cart_Provider>(context, listen: false)
                                  .saveItems(context);
                            },
                          ).show();
                  },
                  child: Custom_Text(
                    text: "Save",
                    fontSize: 13.sp,
                    color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          body: Consumer<Cart_Provider>(builder: (context, value, child) {
            return (value.carts.isEmpty)
                ? Center(
                    child: Custom_Text(
                      text: "No Items",
                      fontSize: 20,
                      color: AppColors.appColor,
                    ),
                  )
                : Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: value.carts.length,
                            itemBuilder: (BuildContext ctx, index) => Container(
                              margin: EdgeInsets.only(bottom: 1.h),
                              child: GestureDetector(
                                onLongPress: () {
                                  Utils_Functions.showMyDialog(
                                      context,
                                      "Remove",
                                      "Cancel",
                                      "Do you want to deduct this item?",
                                      DialogType.warning,
                                      () => Provider.of<Cart_Provider>(context,
                                              listen: false)
                                          .item_Delete(index),
                                      () => Navigator.of(context));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.sp, vertical: 4.sp),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(
                                        8.w), //border corner radius
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors
                                            .appColor, //color of shadow
                                        spreadRadius: 1, //spread radius
                                        blurRadius: 3, // blur radius
                                        offset: Offset(-2,
                                            1), // changes position of shadow
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.sp),
                                              decoration: BoxDecoration(
                                                  color: AppColors.appColor,
                                                  shape: BoxShape.circle
                                              ),
                                              child: Center(
                                                child: Text(
                                                  style: TextStyle(
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.whiteColor),
                                                  '${index+1}',
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3.0.w),
                                            Text(
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.appColor),
                                              '${value.carts[index].item}',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2.0.h),
                                        Row(
                                          children: [
                                            Container(
                                              width: 15.w,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Price",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  )),
                                            ),
                                            //SizedBox(width: 1.0.w),
                                            Container(
                                              width: 60.w,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  Provider.of<Cart_Provider>(
                                                              context)
                                                          .currency_homepage +
                                                      " : " +
                                                      value.carts[index].price,
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        Row(
                                          children: [
                                            Container(
                                              width: 15.w,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Disc:",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(width: 1.0.w),
                                            Container(
                                              width: 60.w,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${value.carts[index].discount}  %",
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 15.w,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Qty:",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(width: 1.0.w),
                                            Container(
                                              width: 40.w,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackColor,
                                                  ),
                                                  '${value.carts[index].quantity}',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.0.h),
                                        Row(
                                          children: [
                                            Container(
                                              width: 15.w,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Total",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ),
                                            SizedBox(width: 1.w),
                                            Container(
                                              width: 60.w,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  Provider.of<Cart_Provider>(
                                                              context)
                                                          .currency_homepage +
                                                      " : " +
                                                      value.carts[index].total,
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackColor,
                                                  ),
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
                          Positioned(
                            bottom: 30,
                            right: 40,
                            child: Custom_Text(
                              text:
                                  "${Provider.of<Cart_Provider>(context, listen: false).currency_homepage + " " + value.sumTotal.toStringAsFixed(2)}",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}

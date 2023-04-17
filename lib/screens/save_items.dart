import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/model/cart_model.dart';
import 'package:pree_bill/model/provider/cart_provider.dart';
import 'package:pree_bill/servicess/database.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SaveItems extends StatefulWidget {
  SaveItems({Key? key, required this.date}) : super(key: key);
  final String date;
  @override
  State<SaveItems> createState() => _SaveItemsState();
}

class _SaveItemsState extends State<SaveItems> {
  @override
  Widget build(BuildContext context) {

    //statusBar color change
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.whiteColor,
    ));

    Provider.of<Cart_Provider>(context, listen: false).getTotalFromTotalColumn(widget.date);

    return WillPopScope(
      onWillPop: () async {
        // This will exit the app instead of going back to the previous screen
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            title: Text(
              'Save items',
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Utils_Functions.navigatePop(context);
              },
              icon: Icon(
                Icons.navigate_before,
                color: AppColors.blackColor,
              ),
            ),
          ),
          body: FutureBuilder<List<Cart_Model>?>(
            future: DatabaseHelper.getDateItems(widget.date),
            builder: (context, AsyncSnapshot<List<Cart_Model>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return Stack(
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 4.sp),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 2.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius:
                              BorderRadius.circular(8.w), //border corner radius
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appColor, //color of shadow
                                  spreadRadius: 1, //spread radius
                                  blurRadius: 3, // blur radius
                                  offset: Offset(-2, 1), // changes position of shadow
                                ),
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
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.appColor),
                                        '${snapshot.data![index].item}',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.0.h),
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
                                                color: AppColors.blackColor,
                                              ),
                                            )),
                                      ),
                                      SizedBox(width: 1.0.w),
                                      Container(
                                        width: 60.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${Provider.of<Cart_Provider>(context, listen: false).currency_homepage + " " + snapshot.data![index].price}",
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
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
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Disc",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blackColor,
                                              ),
                                            )),
                                      ),
                                      SizedBox(width: 1.0.w),
                                      Container(
                                        width: 60.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${snapshot.data![index].discount}  %',
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
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
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Qty:",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blackColor,
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
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.blackColor,
                                            ),
                                            '${snapshot.data![index].quantity}',
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
                                            '${Provider.of<Cart_Provider>(context, listen: false).currency_homepage + " " + snapshot.data![index].total}',
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
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
                        itemCount: snapshot.data!.length,
                      ),
                      Positioned(
                          bottom: 30,
                          right: 40,
                          child : Custom_Text(text: "${Provider.of<Cart_Provider>(context, listen: false).currency_homepage + " " +Provider.of<Cart_Provider>(context, listen: false).uniqueDateOfTotal.toStringAsFixed(2)}" , fontSize: 20,fontWeight: FontWeight.bold, color: AppColors.redColor,)),
                    ]
                  );
                }
                return Center(
                  child: Custom_Text(
                    text: "No Items",
                    fontSize: 20,
                    color: AppColors.appColor,
                  ),
                );
              }
              return Center(
                child: Custom_Text(
                  text: "No Items",
                  fontSize: 20,
                  color: AppColors.appColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

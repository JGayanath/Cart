import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/model/cart_model.dart';
import 'package:pree_bill/model/provider/cart_provider.dart';
import 'package:pree_bill/screens/save_items.dart';
import 'package:pree_bill/servicess/database.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BillDate extends StatefulWidget {
  const BillDate({Key? key}) : super(key: key);

  @override
  State<BillDate> createState() => _BillDateState();
}

class _BillDateState extends State<BillDate> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Custom_Text(
            text: "Bill Date", fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Cart_Model>?>(
                future: Provider.of<Cart_Provider>(context,listen: false).dateAllItems(),
                builder: (context, AsyncSnapshot<List<Cart_Model>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ChangeNotifierProvider<Cart_Provider>(
                        create: (_) => Cart_Provider(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0.sp,
                                mainAxisSpacing: 10.0.sp,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onLongPress: (){
                                    Utils_Functions.showMyDialog(
                                        context,
                                        "Remove",
                                        "Cancel",
                                        "Do you want to remove all items related to this date?",
                                        DialogType.warning,
                                            () {
                                          setState(() {
                                            DatabaseHelper.deleteCartItem(snapshot.data![index].date);
                                          });

                                            },
                                            () => Navigator.of(
                                            context));
                                  },
                                  onTap: (){
                                    Utils_Functions.navigatePush(context, SaveItems(date: snapshot.data![index].date));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      //border: Border.all(width: 2,color:AppColors.appColor),
                                      borderRadius:
                                      BorderRadius.circular(8.w), //border corner radius
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.appColor, //color of shadow
                                          spreadRadius: 1, //spread radius
                                          blurRadius: 3, // blur radius
                                          offset: Offset(-2, 1), // changes position of shadow
                                        ),
                                        //you can set more BoxShadow() here
                                      ],
                                    ),
                                    child: Center(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.appColor),
                                              '${snapshot.data![index].date}',
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            FutureBuilder<List<Cart_Model>?>(
                                              future: DatabaseHelper.getDateItems(snapshot.data![index].date),
                                              builder: (context, AsyncSnapshot<List<Cart_Model>?> snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Center(child: const CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  return Center(child: Text(snapshot.error.toString()));
                                                } else if (snapshot.hasData) {
                                                  if (snapshot.data != null) {
                                                    return ChangeNotifierProvider<Cart_Provider>(
                                                      create: (_) => Cart_Provider(),
                                                      child: Container(
                                                        padding: EdgeInsets.all(3.sp),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.appColor,
                                                          shape: BoxShape.circle
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                fontSize: 15.sp,
                                                                fontWeight: FontWeight.bold,
                                                                color: AppColors.whiteColor),
                                                            '${snapshot.data!.length}',
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return Center(
                                                    child: Custom_Text(
                                                      text: "No Items",
                                                      fontSize: 15.sp,
                                                      color: AppColors.appColor,
                                                    ),
                                                  );
                                                }
                                                return Center(
                                                  child: Custom_Text(
                                                    text: "No Items",
                                                    fontSize: 15.sp,
                                                    color: AppColors.appColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Custom_Text(
                        text: "No Items",
                        fontSize: 15.sp,
                        color: AppColors.appColor,
                      ),
                    );
                  }
                  return Center(
                    child: Custom_Text(
                      text: "No Items",
                      fontSize: 15.sp,
                      color: AppColors.appColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/components/custom_collectbutton.dart';
import 'package:pree_bill/components/custom_floatingbutton.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/components/custom_disc.dart';
import 'package:pree_bill/components/custom_textfieldprice.dart';
import 'package:pree_bill/components/custom_textfieldtotal.dart';
import 'package:pree_bill/components/custom_drawer.dart';
import 'package:pree_bill/model/provider_model/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/assets_image.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'list_price.dart';
import 'package:badges/badges.dart' as badges;

class Pree_Bill extends StatefulWidget {
  Pree_Bill({
    Key? key,
  }) : super(key: key);

  @override
  State<Pree_Bill> createState() => _Pree_BillState();
}

class _Pree_BillState extends State<Pree_Bill> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Navigate drwer

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Provider.of<CartModelProvider>(context,listen: false).priceController;
    Provider.of<CartModelProvider>(context,listen: false).itemController;
    Provider.of<CartModelProvider>(context,listen: false).totalController;
    Provider.of<CartModelProvider>(context,listen: false).discountController;
    Provider.of<CartModelProvider>(context,listen: false).onDiscChange();
    Provider.of<CartModelProvider>(context,listen: false).onTextChanged();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CartModelProvider>(context).currency_assign();
    Provider.of<CartModelProvider>(context,listen: false).totalController.text=Provider.of<CartModelProvider>(context,listen: false).sumTotal.toStringAsFixed(2);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.whiteColor,
    )); //statusbar color change
    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          title: Custom_Text(
              text: "Cart",
              fontSize: 25.0.sp,
              fontWeight: FontWeight.bold),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: AppColors.blackColor,
              size: 20.sp,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Utils_Functions.navigatePush(
                      context,
                      Price_List());
                },
                icon: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: AppColors.redColor,
                    padding: EdgeInsets.all(5),
                  ),
                  badgeAnimation: badges.BadgeAnimation.size(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeContent: Consumer<CartModelProvider>(builder: (context,value,child){
                    return Text('${value.input_Total.length}',style: TextStyle(color: AppColors.whiteColor,),);
                  }),
                  child: Icon(
                    Icons.shopping_cart,
                    color: AppColors.appColor,
                    size: 25.sp,
                  ),
                )
              ),
            ),
          ],
        ),
        drawer: Custom_Drawer(currency_select: () => Provider.of<CartModelProvider>(context,listen: false).currency_select(context)),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 2.0.h),
              child: Column(
                children: [
                  Center(
                    child: FadeIn(
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.appColor.withOpacity(0.2),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.appColor.withOpacity(0.2),
                                spreadRadius: 50.5,
                                blurRadius: 10.0,
                                offset: Offset(3.0, 3.0)),]
                        ),
                        child: FadeInRight(
                          child: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: AppColors.redColor,
                                padding: EdgeInsets.all(15.sp),
                              ),
                              badgeAnimation: badges.BadgeAnimation.size(
                                animationDuration: Duration(seconds: 1),
                                colorChangeAnimationDuration: Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                              badgeContent:
                              Consumer<CartModelProvider>(builder: (context,value,child){
                                return Text('${value.input_Total.length}',style: TextStyle(fontSize:15.sp,color: AppColors.whiteColor,fontWeight: FontWeight.bold),);
                              }),
                              child: Image.asset(Assets_Image.cartProfile,)),
                          delay: Duration(milliseconds: 1500),
                        ),
                      ),
                      delay: Duration(milliseconds: 1500),
                    ),
                  ),
                  // Image.asset(
                  //   Assets_Image.cartProfile,
                  //   height: 20.h,
                  //   width: 40.w,
                  //   fit: BoxFit.cover,
                  // ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    // items select section
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                          30.w), //border corner radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.shade100
                              .withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: const Offset(
                              0, 2), // changes position of shadow
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Align(
                            alignment: Alignment.center,
                            child: Custom_Text(
                                text: "ITEM",
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 60.0.w,
                          child: TextField(
                            onChanged: (_) => Provider.of<CartModelProvider>(context,listen: false).onTextChanged(),
                            autocorrect: true,
                            controller: Provider.of<CartModelProvider>(context,listen: false).itemController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0.sp,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15.sp),
                              hintText: "Name",
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.whiteColor,),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.whiteColor,),
                                borderRadius: BorderRadius.circular(25.7
                                    .w), //------------------------------------------------------------------------------------------------
                              ),
                              //labelText: "Total",
                              labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),
                              //label style
                              //Icon(null),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    // input price section
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                          30.w), //border corner radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.shade100
                              .withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: const Offset(
                              0, 2), // changes position of shadow
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20.w,
                          child: Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Provider.of<CartModelProvider>(context,listen: false).currency_select(context);
                                  //Navigator.pop(context);
                                },
                                child: Text(
                                    Provider.of<CartModelProvider>(context).currency_homepage,
                                  style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  //controller: currency_filed,
                                ),
                              )),
                        ),
                        Container(
                          width: 60.w,
                          child: Custom_TextFieldPrice(
                              function: ()=> Provider.of<CartModelProvider>(context,listen: false).onDiscChange()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),

                  Container(
                    // input price section
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                          30.w), //border corner radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.shade100
                              .withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: const Offset(
                              0, 2), // changes position of shadow
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20.w,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "DISC",
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                                //controller: currency_filed,
                              )),
                        ),
                        Container(
                          width: 60.w,
                          child: Custom_Disc(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Align(
                            alignment: Alignment.center,
                            child: Custom_Text(
                                text: "QTY:",
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Custom_FloatingButton(
                              icon: Icon(
                                Icons.remove,
                                color: AppColors.whiteColor,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                //value_decrease();
                                Provider.of<CartModelProvider>(context,listen: false).value_decrease();
                              }),
                        ),
                        Container(
                          width: 20.w,
                          child: Consumer<CartModelProvider>(builder: (context,value , child) {
                            return Text(
                              textAlign: TextAlign.center,
                              "${value.quantity}",
                              style: TextStyle(
                                fontSize: 15.0.sp,
                              ),
                            );
                          }
                          ),
                        ),
                        Container(
                          child: Custom_FloatingButton(
                              icon: Icon(
                                Icons.add,
                                color: AppColors.whiteColor,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                //value_increase();
                                Provider.of<CartModelProvider>(context,listen: false).value_increase();
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20.w,
                        child: Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Provider.of<CartModelProvider>(context,listen: false).currency_select(context);
                              },
                              child: Text(
                                  Provider.of<CartModelProvider>(context).currency_homepage,
                                style: TextStyle(
                                    color: AppColors.appColor,
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.bold),
                                //controller: currency_filed,
                              ),
                            )),
                      ),
                      Container(
                        width: 60.w,
                        child: Custom_TextFieldTotal(controller: Provider.of<CartModelProvider>(context,listen: false).totalController,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Custom_CollectButton(
                        onPressed: () {
                          Provider.of<CartModelProvider>(context , listen: false).get_price();
                        }),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<CartModelProvider>(context , listen: false).clear_all(context);
                    },
                    child: Text('Clear',style: TextStyle(color: AppColors.blackColor),),
                  ),
                  SizedBox(
                    height: 1.0.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:pree_bill/components/custom_collectbutton.dart';
import 'package:pree_bill/components/custom_floatingbutton.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/components/custom_disc.dart';
import 'package:pree_bill/components/custom_textfielditem.dart';
import 'package:pree_bill/components/custom_textfieldprice.dart';
import 'package:pree_bill/components/custom_textfieldtotal.dart';
import 'package:pree_bill/components/custom_drawer.dart';
import 'package:pree_bill/model/provider/cart_provider.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;



class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();// Navigate drwer
  @override
  Widget build(BuildContext context) {
    Provider.of<Cart_Provider>(context).currency_assign();
    Provider.of<Cart_Provider>(context, listen: false)
            .totalController
            .text =
        Provider.of<Cart_Provider>(context, listen: false)
            .sumTotal
            .toStringAsFixed(2);


    //statusBar color change
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.whiteColor,
    )); //statusbar color change

    return WillPopScope(
      onWillPop: () async {
        // This will exit the app instead of going back to the previous screen
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _key,
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            title: Custom_Text(
                text: "Cart", fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: AppColors.blackColor,
                size: 18.sp,
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
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
                    badgeContent: Consumer<Cart_Provider>(builder: (context,value,child){
                      return Text('${value.carts.length}',style: TextStyle(color: AppColors.whiteColor,),);
                    }),
                    child: Icon(
                      Icons.shopping_cart,
                      color: AppColors.appColor,
                      size: 25.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          drawer: Custom_Drawer(
            //-----change currency
              currency_select: () =>
                  Provider.of<Cart_Provider>(context, listen: false)
                      .currency_select(context)),
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 10.0.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                KeyboardVisibilityBuilder(builder: (context, visible) {
                  return visible ?  Expanded(
                    flex: 4,
                    child: Center(
                      child: Lottie.asset(
                        "assets/images/shop.json",
                        fit: BoxFit.fill,
                      ),
                    ),
                  )  : Expanded(
                    flex: 11,
                    child: Center(
                      child: Lottie.asset(
                        "assets/images/shop.json",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ) ;
                }),

                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // items select section
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                          BorderRadius.circular(30.w), //border corner radius
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
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 60.0.w,
                          child: Custom_TextFieldItem(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // input price section
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                          BorderRadius.circular(30.w), //border corner radius
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
                              child: InkWell(
                                onTap: () {
                                  Provider.of<Cart_Provider>(context,
                                      listen: false)
                                      .currency_select(context);
                                  //Navigator.pop(context);
                                },
                                child: Text(
                                  Provider.of<Cart_Provider>(context)
                                      .currency_homepage,
                                  style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                  //controller: currency_filed,
                                ),
                              )),
                        ),
                        Container(
                          width: 60.w,
                          child: Custom_TextFieldPrice(
                              function: () => Provider.of<Cart_Provider>(
                                      context,
                                      listen: false)
                                  .onDiscChange()),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // input price section
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                          BorderRadius.circular(30.w), //border corner radius
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
                                    fontSize: 12.sp,
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
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Align(
                            alignment: Alignment.center,
                            child: Custom_Text(
                                text: "QTY",
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Custom_FloatingButton(
                            heroTag: "minus",
                              icon: Icon(
                                Icons.remove,
                                color: AppColors.whiteColor,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                //value_decrease();
                                Provider.of<Cart_Provider>(context,
                                        listen: false)
                                    .value_decrease();
                              }),
                        ),
                        Container(
                          width: 20.w,
                          child: Consumer<Cart_Provider>(
                              builder: (context, value, child) {
                            return Text(
                              textAlign: TextAlign.center,
                              "${value.quantity}",
                              style: TextStyle(
                                fontSize: 12.0.sp,
                              ),
                            );
                          }),
                        ),
                        Container(
                          child: Custom_FloatingButton(
                              heroTag: "plus",
                              icon: Icon(
                                Icons.add,
                                color: AppColors.whiteColor,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                //value_increase();
                                Provider.of<Cart_Provider>(context,
                                        listen: false)
                                    .value_increase();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20.w,
                        child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Provider.of<Cart_Provider>(context,
                                    listen: false)
                                    .currency_select(context);
                                //Navigator.pop(context);
                              },
                              child: Text(
                                Provider.of<Cart_Provider>(context)
                                    .currency_homepage,
                                style: TextStyle(
                                    color: AppColors.appColor,
                                    fontSize: 15.0.sp,
                                    fontWeight: FontWeight.bold),
                                //controller: currency_filed,
                              ),
                            )),
                      ),
                      Container(
                        width: 60.w,
                        child: Custom_TextFieldTotal(
                          controller: Provider.of<Cart_Provider>(context,
                                  listen: false)
                              .totalController,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Custom_CollectButton(onPressed: () {
                      Provider.of<Cart_Provider>(context, listen: false)
                          .get_price(context);
                    }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Provider.of<Cart_Provider>(context, listen: false)
                            .clear_all(context);
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(color: AppColors.blackColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


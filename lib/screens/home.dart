import 'package:animate_do/animate_do.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pree_bill/components/custom_collectbutton.dart';
import 'package:pree_bill/components/custom_floatingbutton.dart';
import 'package:pree_bill/components/custom_text.dart';
import 'package:pree_bill/components/custom_textfieldprice.dart';
import 'package:pree_bill/components/custom_textfieldtotal.dart';
import 'package:pree_bill/components/custom_drawer.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/assets_image.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'list_price.dart';
import '../model/model.dart';
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
  late final prefs = SharedPreferences;
  String _currency_homepage = "USD";

  final TextEditingController item_Price = TextEditingController();
  late final TextEditingController item_Total = TextEditingController();
  final TextEditingController item_Select = TextEditingController();

  @override
  void initState() {
    super.initState();
    //findPriceData();
    currency_assign();
    item_Price.text = "";
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    item_Price.dispose();
    item_Total.dispose();
    item_Select.dispose();
    super.dispose();
  }

  double quantity = 0.0;
  late double price;
  late double total_Price;
  late double after_total;
  late double after_add_price;
  double totalHome = 0.0;
  List<String> input_Price = []; // price list varible
  List<String> input_Total = []; // price list varible
  List<double> input_Quantity = []; // price list varible
  List<String> itemSelects = []; // selected your items

  void currency_assign() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      (prefs.getString('currency_key')!.isEmpty)
          ? _currency_homepage = "USD"
          : _currency_homepage = prefs.getString('currency_key').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Model>(context);
    item_Total.text = provider.sumTotal.toStringAsFixed(2);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    )); //statusbar color change

    Future<void> currency_select() async {
      // Change currency of navigate drawer
      final prefs = await SharedPreferences.getInstance();
      showCurrencyPicker(
          context: context,
          showFlag: true,
          showCurrencyName: true,
          showCurrencyCode: true,
          onSelect: (Currency currency) {
            _currency_homepage = (currency.code);
            setState(
              () {
                prefs.setString('currency_key', _currency_homepage);
                //Pree_Bill();
              },
            );
          });
    }



    void get_price() {
      setState(() {
          if (item_Price.text.isEmpty) {
          Utils_Functions.toast("Input your price");
        } else if (quantity == 0.0) {
          Utils_Functions.toast("input your quantity");
        } else if(item_Select.text.isEmpty){
            Utils_Functions.toast("input your item name");
          } else {
          after_total = double.parse(item_Total.text);
          input_Price.add(item_Price.text); // price list varible
          itemSelects.add(item_Select.text);
          price = double.parse(item_Price.text);
          after_add_price = price * quantity;
          provider.updateValue(after_add_price + after_total);
          item_Total.text = (provider.sumTotal).toStringAsFixed(2);
          totalHome = double.parse(item_Total.text);
          item_Price.text = "";
          input_Quantity.add(quantity); // price list varible
          quantity = 0;
          input_Total
              .add(after_add_price.toStringAsFixed(2)); // price list varible
          item_Select.text="";
        }
      });
    }

    void clear() {
      setState(() {
        item_Price.text = "";
        quantity = 0.00;
        input_Total.clear();
        input_Price.clear();
        input_Quantity.clear();
        itemSelects.clear();
        item_Select.text="";
        provider.updateValue(0);
      });

    }

    void clear_all() {
      // clear all
      if (item_Price.text.isEmpty && provider.sumTotal==0.00 && item_Select.text.isEmpty && quantity==0.00 ) {
        Utils_Functions.toast("You don't have any values");
      } else {
        Utils_Functions.showMyDialog(
            context,
            "Remove",
            "Cancel",
            "Do you need clear all data?",
            DialogType.warning,
                () => clear(),
                () => Navigator.of(context));
      }
    }

    void value_increase() {
      // increase quanity
      setState(() {
        quantity += 0.5;
      });
    }

    void value_decrease() {
      // decrease quanity
      setState(() {
        if (quantity >= 0.5) {
          quantity -= 0.5;
        }
      });
    }
    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
              color: Colors.black,
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
                      Price_List(
                        price: input_Price,
                        total: input_Total,
                        quantity: input_Quantity,
                        totalHome: totalHome,
                        slectedItems: itemSelects,
                      ));
                },
                icon: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Color(0xffFF0000),
                    padding: EdgeInsets.all(5),
                  ),
                  badgeAnimation: badges.BadgeAnimation.size(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeContent:
                  Text('${input_Total.length}',style: TextStyle(color: Colors.white),),
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
        drawer: Custom_Drawer(currency_select: () => currency_select()),
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
                          color: Color(0xFF304FFE).withOpacity(0.2),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF304FFE).withOpacity(0.1),
                                spreadRadius: 50.5,
                                blurRadius: 10.0,
                                offset: Offset(3.0, 3.0)),]
                        ),
                        child: FadeInRight(
                          child: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Color(0xffFF0000),
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
                              Text('${input_Total.length}',style: TextStyle(fontSize:15.sp,color: Colors.white,fontWeight: FontWeight.bold),),
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
                      color: Colors.white,
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
                                text: "Item",
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 60.0.w,
                          child: TextField(
                            textCapitalization: TextCapitalization.values.first,
                            autocorrect: true,
                            controller: item_Select,
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
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7
                                    .w), //------------------------------------------------------------------------------------------------
                              ),
                              //labelText: "Total",
                              labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
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
                      color: Colors.white,
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
                                  currency_select();
                                  //Navigator.pop(context);
                                },
                                child: Text(
                                  _currency_homepage,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                  //controller: currency_filed,
                                ),
                              )),
                        ),
                        Container(
                          width: 60.w,
                          child: Custom_TextFieldPrice(
                              item_Price: item_Price),
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
                                text: "Qty:",
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Custom_FloatingButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onPressed: () => value_decrease()),
                        ),
                        Container(
                          width: 20.w,
                          child: Text(
                            textAlign: TextAlign.center,
                            "$quantity",
                            style: TextStyle(
                              fontSize: 15.0.sp,
                            ),
                          ),
                        ),
                        Container(
                          child: Custom_FloatingButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onPressed: () => value_increase()),
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
                                currency_select();
                              },
                              child: Text(
                                _currency_homepage,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.bold),
                                //controller: currency_filed,
                              ),
                            )),
                      ),
                      Container(
                        width: 60.w,
                        child: Consumer<Model>(
                          builder: (context, person, child) {
                            return Custom_TextFieldTotal(
                                item_Total: item_Total);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Custom_CollectButton(
                        onPressed: () => get_price()),
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
                      clear_all();
                    },
                    child: Text('Clear',style: TextStyle(color: Colors.black),),
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

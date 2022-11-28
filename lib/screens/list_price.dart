import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/model/model.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'home.dart';

class Price_List extends StatefulWidget {
  List<String> price = [];
  List<String> total = [];
  List<double> quantity = [];
  List<String> slectedItems = [];
  late double totalHome;

  Price_List(
      {required this.price,
      required this.total,
      required this.quantity,
      required this.totalHome,
      required this.slectedItems});

  @override
  State<Price_List> createState() => _Price_ListState();
}

class _Price_ListState extends State<Price_List> {
  final prefs = SharedPreferences;
  String _currency_homepage = "USD";

  @override
  void initState() {
    super.initState();
    currency_assign(); //currency run time view
  }

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
    final provider = Provider.of<Model>(context); // provider package object

    void item_Delete(index) {
      // List view builder selected item delete
      setState(() {
        String getTotal = "";
        double checkMinusValue = 0; // plus or minus check value
        if (checkMinusValue >= 0) {
          widget.price.removeAt(index);
          widget.quantity.removeAt(index);
          getTotal = widget.total.removeAt(index);
          checkMinusValue = widget.totalHome - double.parse(getTotal);
          provider.updateValue(checkMinusValue);
          widget.totalHome = provider.sumTotal;
        }
      });
    }

    return SafeArea(
      top: false,
      left: false,
      bottom: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Price List',
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0.sp,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Utils_Functions.navigatePop(context);
            },
            icon: Icon(
              Icons.navigate_before_outlined,
              color: Colors.black,
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
                    color: Colors.indigoAccent[700],
                    size: 30.0.sp,
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
                        "${_currency_homepage + " " + provider.sumTotal.toStringAsFixed(2)}",
                        DialogType.info,
                        () => Navigator.of(context),() => Utils_Functions.navigatePop(context));
                  },
                  icon: Icon(
                    Icons.info,
                    color: Colors.indigoAccent[700],
                    size: 30.0.sp,
                  )),
              label: "",
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h , horizontal: 2.w),
            child: ListView.builder(
              itemCount: widget.price.length,
              itemBuilder: (BuildContext ctx, index) => Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0.w)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h , horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigoAccent[700]),
                                '${widget.slectedItems[index]}',
                              ),
                            ],
                          ),
                          SizedBox(height: 1.0.h),
                          Row(
                            children: [
                              Container(
                                width: 20.w,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Price",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                              SizedBox(width: 1.0.w),
                              Container(
                                width: 30.w,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _currency_homepage +
                                          " : " +
                                          widget.price[index],
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(width: 1.0.w),
                          Row(
                            children: [
                              Container(
                                width: 20.w,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Qty:",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                              SizedBox(width: 1.0.w),
                              Container(
                                width: 20.w,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      '${widget.quantity[index]}',
                                    )),
                              ),
                              SizedBox(width: 5.0.w),
                              Container(
                                width: 30.w,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0.w,
                                              color:
                                                  Colors.indigoAccent.shade700),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                            icon: Icon(Icons.delete,
                                                size: 20.sp,
                                                color:
                                                    Colors.indigoAccent[700]),
                                            onPressed: () {
                                              Utils_Functions.showMyDialog(
                                                  context,
                                                  "Remove",
                                                  "Cancel",
                                                  "Do you want to deduction this item?",
                                                  DialogType.warning,
                                                  () => item_Delete(index),() => Navigator.of(context));
                                            }))),
                              ),
                            ],
                          ),
                          SizedBox(width: 1.0.w),
                          Row(
                            children: [
                              Container(
                                width: 20.w,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Total",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              SizedBox(width: 1.w),
                              Container(
                                width: 30.w,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _currency_homepage +
                                          " : " +
                                          widget.total[index],
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
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
        ),
      ),
    );
  }
}

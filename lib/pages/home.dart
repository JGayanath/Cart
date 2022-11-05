import 'package:currency_picker/currency_picker.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'items.dart';
import 'list_price.dart';
import 'model.dart';

class Pree_Bill extends StatefulWidget {
  late double price_List_Total;
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

  TextEditingController item_Price = TextEditingController();
  TextEditingController item_Total = TextEditingController();
  TextEditingController _controller = TextEditingController();

  //TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //findPriceData();
    item_Total = TextEditingController();
    currency_assign();
    button_Submit();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    item_Price.dispose();
    item_Total.dispose();
    super.dispose();
  }

  double quantity = 0.0;
  late double price;
  late double total_Price;
  late double after_total;
  late double after_add_price;
  double totalHome = 0.0;
  bool submit = false;
  List<String> input_Price = []; // price list varible
  List<String> input_Total = []; // price list varible
  List<double> input_Quantity = []; // price list varible
  List<String> status = []; // add or deduction

  void currency_assign() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      (prefs.getString('currency_key')!.isEmpty)
          ? _currency_homepage = "USD"
          : _currency_homepage = prefs.getString('currency_key').toString();
    });
  }

  void button_Submit() {
    item_Price.addListener(() {
      setState(() {
        submit = item_Price.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    )); //statusbar color change

    final provider = Provider.of<Model>(context);
    final itemsModel = Items();

    item_Total.text = provider.sumTotal.toStringAsFixed(2);

    void _navigatetoPrice_list(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              Price_List(
                  price: input_Price,
                  total: input_Total,
                  quantity: input_Quantity,
                  status: status,
                  totalHome: totalHome)));
    }

    Future<void> _currency_select() async {
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
      // Calculate Price
      //double current_input_Price = double.parse(item_Price.text);
      setState(() {
        double current_price1 = double.parse(item_Price.text);
        if (quantity == 0.0 || current_price1 == 0.00) {
          Fluttertoast.showToast(
              msg: " Check your price or quantity",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          after_total = double.parse(item_Total.text);
          input_Price.add(item_Price.text); // price list varible
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
          status.add("Collect");
        }
      });
    }

    void deduction() {
      // need validation more
      setState(() {
        double current_quantity = quantity;
        double current_price3 = double.parse(item_Price.text);
        double current_total_value = double.parse(item_Total.text);
        double current_total = current_price3 * current_quantity;
        if (current_total_value >= 0 &&
            current_quantity >= 0.5 &&
            current_total <= current_total_value &&
            current_price3 >= 0.1) {
          provider.updateValue(current_total_value - current_total);
          item_Total.text = (provider.sumTotal).toStringAsFixed(2);
          input_Price.add(item_Price.text); // price list varible
          input_Quantity.add(quantity); // price list varible
          input_Total
              .add(current_total.toStringAsFixed(2)); // price list varible
          totalHome = double.parse(item_Total.text);
          current_quantity = 0.00;
          current_price3 = 0.00;
          current_total_value = 0.00;
          current_total = 0.00;
          item_Price.text = "";
          quantity = 0.0;
          status.add("Deduction");
        } else {
          Fluttertoast.showToast(
              msg: " Check your value",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        ;
      });
    }

    void clear_all() {
      // clear all
      setState(() {
        item_Price.text = "";
        quantity = 0.0;
        item_Total.text = provider.updateValue(0).toString();
        input_Price.clear();
        input_Quantity.clear();
        input_Total.clear();
        status.clear();
      });
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

    var selected;
    List selectedList;

    return SafeArea(
      top: false,
      left: false,
      bottom: false,
      right: false,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Pree Bill",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _navigatetoPrice_list(context);
              },
              icon: const Icon(
                Icons.navigate_next_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              const DrawerHeader(
                margin: const EdgeInsets.all(50.0),
                child: const Text(""),
                decoration: const BoxDecoration(
                  image: const DecorationImage(
                    image: const ExactAssetImage('assets/images/Pay_drow.png'),
                    fit: BoxFit.cover,
                  ),
                  //color: Color(0xff1a237e),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.indigoAccent[700],
                      size: 30.0,
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    const Text(
                      "Home",
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.price_change_sharp,
                      color: Colors.indigoAccent[700],
                      size: 30.0,
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    const Text(
                      "Change Currency",
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                onTap: () {
                  _currency_select();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.indigoAccent[700],
                      size: 30.0,
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    const Text(
                      "About",
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            child: SvgPicture.asset(
                                'assets/images/Pay_Bill.svg',
                                height: 300,
                                width: 300,
                                fit: BoxFit.scaleDown),
                          ),
                          const SizedBox(
                            height: 20.00,
                          ),

                          Container( // items select section
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  30), //border corner radius
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Item",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold),
                                        //controller: currency_filed,
                                      )),
                                ),
                                SizedBox(
                                  width: 250,
                                  child:
                                  CustomSearchableDropDown(
                                    labelStyle: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                    labelAlign: TextAlign.center,
                                    showClearButton: false,
                                    items: Items.items,
                                    label: 'Select Name',
                                    dropDownMenuItems: Items.items?.map((item) {
                                      return item;
                                    })?.toList() ??
                                        [],
                                    onChanged: (value){
                                      if(value!=null)
                                      {
                                        selected = value.toString();
                                      }
                                      else{
                                        selected=null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          Container( // input price section
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  30), //border corner radius
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () {
                                          _currency_select();
                                          //Navigator.pop(context);
                                        },
                                        child: Text(
                                          _currency_homepage,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold),
                                          //controller: currency_filed,
                                        ),
                                      )),
                                ),
                                Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  child: TextField(
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
                                    controller: item_Price,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(

                                      fontSize: 20.0,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.indigoAccent[700],
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: Colors.white),

                                        borderRadius:
                                        BorderRadius.circular(25.7),
                                      ),
                                      //labelText: 'Price',
                                      labelStyle: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold),
                                      //label style//Icon(null),
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      hintText: "Your Price",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.00,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: const Text(
                                      "Qty :",
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 35.0),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      value_decrease();
                                    },
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        value_decrease();
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.indigoAccent[700],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 75.0,
                                  margin: const EdgeInsets.fromLTRB(
                                      10.0, 0, 10, 0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "$quantity",
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                                Container(
                                    child: GestureDetector(
                                      onLongPress: () {
                                        value_increase();
                                      },
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          value_increase();
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors
                                            .indigoAccent[700],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  30), //border corner radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.shade100
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                                //you can set more BoxShadow() here
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () {
                                          _currency_select();
                                        },
                                        child: Text(
                                          _currency_homepage,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold),
                                          //controller: currency_filed,
                                        ),
                                      )),
                                ),
                                Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  child: Consumer<Model>(
                                    builder: (context, person, child) {
                                      return TextField(
                                        readOnly: true,
                                        controller: item_Total,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 25.0,
                                        ),
                                        keyboardType: TextInputType.none,
                                        decoration: InputDecoration(
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(25.7),
                                          ),
                                          //labelText: "Total",
                                          labelStyle: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .bold),
                                          //label style
                                          prefixIcon: null,
                                          //Icon(null),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.00,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              deduction();
                            },
                            child: const Text(
                              'Deduction',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                              child: Container(
                                //margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                height: 60.0,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 1,
                                child: RaisedButton(
                                  onPressed: submit ? () => get_price() : null,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(80.0)),
                                  color: Colors.indigoAccent[700],
                                  disabledColor: Colors.indigoAccent[100],
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Collect",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              clear_all();
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pree_bill/model/cart_model.dart';
import 'package:pree_bill/servicess/database.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Cart_Provider extends ChangeNotifier {

  late final prefs = SharedPreferences;
  String currency_homepage = "USD";

  double quantity = 0.0;
  late double price;
  late double total_Price;
  late double after_total;
  late double after_add_price;
  late double discount;
  double totalHome = 0.0;
  double sumTotal = 0.00;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // date formatter change
  List<Cart_Model> carts = [];
  late double uniqueDateOfTotal; // get total in cart table from total column of unique date

  //----item controller
  final _item = TextEditingController();
  //--- return item controller
  TextEditingController get itemController => _item;

  //----price controller
  final _price = TextEditingController();
  //--- return price controller
  TextEditingController get priceController => _price;

  //----discount controller
  final _discount = TextEditingController();
  //----return discount controller
  TextEditingController get discountController => _discount;

  //----total controller
  final _total = TextEditingController();
  //----return total controller
  TextEditingController get totalController => _total;

  //---set item
  set setItem(String item) {
    _item.text = item;
    notifyListeners();
  }

  //---set price
  set setPrice(String price) {
    _price.text = price;
    notifyListeners();
  }

  //---set discount
  set setDiscount(String discount) {
    _discount.text = discount;
    notifyListeners();
  }

  //---set quantity
  set setQuantity(double quantity) {
    quantity = quantity;
    notifyListeners();
  }

  //---set total
  set setTotal(String total) {
    _discount.text = total;
    notifyListeners();
  }

  void value_increase() {
    // increase quanity
    quantity += 0.5;
    notifyListeners();
  }

  void value_decrease() {
    // decrease quanity
    if (quantity >= 0.5) {
      quantity -= 0.5;
      notifyListeners();
    }
  }

  void get_price(BuildContext context) {
    if (priceController.text.isEmpty) {
      Utils_Functions.toast("Input your price");
    } else if (quantity == 0.0) {
      Utils_Functions.toast("input your quantity");
    } else if (itemController.text.isEmpty) {
      Utils_Functions.toast("input your item name");
    } else if (discountController.text.isEmpty) {
      Utils_Functions.toast("input your discount");
    } else {
      try {
        discount = double.parse(discountController.text);
        after_total = double.parse(totalController.text);
        price = double.parse(priceController.text);
        after_add_price = price * quantity;
        sumTotal = ((after_add_price - (after_add_price / 100 * discount)) +
            after_total);
        totalController.text = sumTotal.toStringAsFixed(2);
        totalHome = double.parse(totalController.text);

        //------------- add to listmodel for item
        carts.add(Cart_Model(
            date: formattedDate.toString(),
            item: itemController.text.toString(),
            price: priceController.text.toString(),
            discount: discountController.text.toString(),
            quantity: quantity.toString(),
            total: (after_add_price - (after_add_price / 100 * discount))
                .toStringAsFixed(2)));
        priceController.clear();
        quantity = 0;
        itemController.clear();
        discountController.clear();
        notifyListeners();
      } catch (e) {
        Logger().e(e);
        AwesomeDialog(
          btnOkText: "Ok",
          btnOkColor: AppColors.appColor,
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: Container(
            padding: EdgeInsets.all(10.sp),
            child: Text(
              "${e.toString()}",
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
        ).show();
      }
    }
  }

  //-------- discount filed auto insert when select price
  void onDiscChange() {
    final text = discountController.text;
    if (text.isEmpty) {
      discountController.text = 0.toStringAsFixed(1);
      notifyListeners();
    }
  }

  //---------- item field first letter capitalize
  void onTextChanged() {
    final text = itemController.text;
    if (text.isNotEmpty) {
      itemController.text =
          text.substring(0, 1).toUpperCase() + text.substring(1);
      itemController.selection = TextSelection.fromPosition(
          TextPosition(offset: itemController.text.length));
    }
  }

  //--------------clear text field
  void clearHome() {
    //carts.clear();
    quantity = 0.00;
    discountController.clear();
    itemController.clear();
    priceController.text = "";
    //sumTotal = 0.00;
    //totalController.text = sumTotal.toStringAsFixed(2);
    notifyListeners();
  }

  void clear_all(BuildContext context) {
    // clear all
    if (priceController.text.isEmpty &&
        itemController.text.isEmpty &&
        quantity == 0.00 &&
        discountController.text.isEmpty) {
      Utils_Functions.toast("You don't have any values");
    } else {
      Utils_Functions.showMyDialog(
          context,
          "Remove",
          "Cancel",
          "Do you need clear all data?",
          DialogType.warning,
          () => clearHome(),
          () => Navigator.of(context));
    }
  }


  //item list clear
  void clearList(){
    carts.clear();
    sumTotal=0.00;
    notifyListeners();
  }

  // list item clear
  void listItemsClear(BuildContext context){
    // check if empty
    if(carts.isEmpty){
      Utils_Functions.toast("You don't have items");
    }else {
      Utils_Functions.showMyDialog(
          context,
          "Remove",
          "Cancel",
          "Do you need clear all data?",
          DialogType.warning,
              () => clearList(),
              () => Navigator.of(context),
      );
    }
  }

  void item_Delete(index) {
    // List view builder selected item delete
    String getTotal = "0";

    // remove item from index and get Map type variable
    Map<String, dynamic> maps = carts.removeAt(index).toJson();

    // get total value relevant remove item
    getTotal = maps.remove("total");

    //decrease from remove item total value from current total
    sumTotal = sumTotal - double.parse(getTotal);

    // assing value new current total
    totalController.text = sumTotal.toStringAsFixed(2);
    notifyListeners();
  }

  void currency_assign() async {
    final prefs = await SharedPreferences.getInstance();
    (prefs.getString('currency_key')==null)
        ? currency_homepage = "USD"
        : currency_homepage = prefs.getString('currency_key').toString();
    notifyListeners();
  }

  Future<void> currency_select(BuildContext context) async {
    // Change currency of navigate drawer
    final prefs = await SharedPreferences.getInstance();
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        currency_homepage = (currency.code);
        prefs.setString('currency_key', currency_homepage);
        //Pree_Bill();
      },
    );
    notifyListeners();
  }

  Future<void> saveItems(BuildContext context) async {
    String date = "0";
    String item = "0";
    String price = "0";
    String discount = "0";
    String quantity = "0";
    String total = "0";
    try {
      for (int i = 0; i < carts.length; i++) {
        // add all items details from for loop one by one
        date = formattedDate.toString();
        item = carts[i].item.toString();
        price = carts[i].price.toString();
        discount = carts[i].discount.toString();
        quantity = carts[i].quantity.toString();
        total = carts[i].total.toString();

        // assing model class to one by one item details
        final Cart_Model modelCart = await Cart_Model(
            date: date,
            item: item,
            price: price,
            discount: discount,
            quantity: quantity,
            total: total);

        //--- add to model items to database table
        await DatabaseHelper.addCart(modelCart);
      }
      carts.clear();
      sumTotal=0.00;
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
      AwesomeDialog(
        btnOkText: "Ok",
        btnOkColor: AppColors.appColor,
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        body: Container(
          padding: EdgeInsets.all(10.sp),
          child: Text(
            "${e.toString()}",
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
      ).show();
    }
  }

  // get getUniqueDate
  Future<List<Cart_Model>?> dateAllItems() async{
    List<Cart_Model>? map = await DatabaseHelper.getUniqueDate();
    notifyListeners();
    return map;
  }

  // getUniqueDate items delete
  Future<List<Cart_Model>?> deleteItems(String date , BuildContext context) async{
     DatabaseHelper.deleteCartItem(date);
    notifyListeners();
    Provider.of<Cart_Provider>(context,listen: false).dateAllItems();
  }

  // assing to UniqueDate in the sum of total items in cart table
  Future<void> getTotalFromTotalColumn(String date) async{
    uniqueDateOfTotal = await DatabaseHelper.getTotal(date);
    notifyListeners();
  }
}

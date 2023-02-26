
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/utils/utils_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModelProvider extends ChangeNotifier{

  late final prefs = SharedPreferences;
  String currency_homepage = "USD";

  late List<String> input_items = []; // selected your items
  late List<String> input_Price = []; // price list varible
  late List<String> itemDiscounts = []; //  selected discount
  late List<double> input_Quantity = []; // price list varible
  late List<String> input_Total = []; // price list varible
  //late double totalHome;

  double quantity=0.0;
  late double price;
  late double total_Price;
  late double after_total;
  late double after_add_price;
  late double discount;
  double totalHome = 0.0;
  double sumTotal=0.00;

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
   set setItem(String item){
     _item.text=item;
     notifyListeners();
   }

  //---set price
   set setPrice(String price){
     _price.text=price;
     notifyListeners();
   }

  //---set discount
  set setDiscount(String discount){
    _discount.text=discount;
    notifyListeners();
  }

  //---set quantity
  set setQuantity(double quantity){
    quantity=quantity;
    notifyListeners();
  }

  //---set total
  set setTotal(String total){
    _discount.text=total;
    notifyListeners();
  }

  void value_increase() {
    // increase quanity
      quantity += 0.5;
   notifyListeners();
   print(quantity);
  }

  void value_decrease() {
    // decrease quanity
      if (quantity >= 0.5) {
        quantity -= 0.5;
        notifyListeners();
        print(quantity);
      }
  }

  void get_price() {
      if (priceController.text.isEmpty) {
        Utils_Functions.toast("Input your price");
      } else if (quantity == 0.0) {
        Utils_Functions.toast("input your quantity");
      } else if(itemController.text.isEmpty){
        Utils_Functions.toast("input your item name");
      } else if(discountController.text.isEmpty) {
        Utils_Functions.toast("input your discount");
      } else{
        discount = double.parse(discountController.text);
        after_total = double.parse(totalController.text);
        input_Price.add(priceController.text); // price list varible
        input_items.add(itemController.text);
        itemDiscounts.add(discountController.text);
        price = double.parse(priceController.text);
        after_add_price = price*quantity;
        sumTotal=((after_add_price-(after_add_price/100*discount))+after_total);
        totalController.text = sumTotal.toStringAsFixed(2);
        totalHome = double.parse(totalController.text);
        priceController.text = "";
        input_Quantity.add(quantity); // price list varible
        quantity = 0;
        input_Total.add((after_add_price-(after_add_price/100*discount)).toStringAsFixed(2)); // price list varible
        itemController.text="";
        discountController.clear();
        notifyListeners();
      }
  }

  void printTab(){
     print(itemController.text);
     print(discountController.text);
     print(priceController.text);
  }

  //-------- discount filed auto insert when select price
  void onDiscChange(){
    final text = discountController.text;
      if(text.isEmpty){
        discountController.text= 0.toStringAsFixed(1);
        notifyListeners();
      }
  }

  //---------- item field first letter capitalize
  void onTextChanged() {
    final text = itemController.text;
    if (text.isNotEmpty) {
      itemController.text = text.substring(0, 1).toUpperCase() + text.substring(1);
      itemController.selection = TextSelection.fromPosition(
          TextPosition(offset: itemController.text.length));
    }
  }

  //--------------clear text field
  void clear() {
      input_Total.clear();
      input_Price.clear();
      input_Quantity.clear();
      itemDiscounts.clear();
      input_items.clear();

      quantity = 0.00;
      discountController.clear();
      itemController.clear();
      priceController.text = "";
      sumTotal=0.00;
      totalController.text=sumTotal.toStringAsFixed(2);
      notifyListeners();
  }

  void clear_all(BuildContext context) {
    // clear all
    if (priceController.text.isEmpty && sumTotal==0.00 && itemController.text.isEmpty && quantity==0.00 && discountController.text.isEmpty ) {
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

  void item_Delete(index) {
    // List view builder selected item delete
    String getTotal = "";
      input_Price.removeAt(index);
      input_items.removeAt(index);
      input_Quantity.removeAt(index);
      getTotal = input_Total.removeAt(index);
      sumTotal=sumTotal-double.parse(getTotal);
      itemDiscounts.removeAt(index);
      totalController.text=sumTotal.toStringAsFixed(2);
      notifyListeners();
    }

  void currency_assign() async {
    final prefs = await SharedPreferences.getInstance();
      (prefs.getString('currency_key')!.isEmpty)
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
          notifyListeners();
              //Pree_Bill();
            },
          );
  }

}
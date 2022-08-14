
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class Select extends StatefulWidget {
  const Select({Key? key}) : super(key: key);

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {

  final prefs = SharedPreferences;
  String _currency_code="";
  bool isloader=true;

  @override
  void initState() {
    super.initState();
    _currency_get();

  }

  Future<void> _next_Screen()async{
    final prefs = await SharedPreferences.getInstance();
    //_currency_code = prefs.getString('currency_key').toString();
    if (prefs.getString('currency_key')!.isEmpty) {
      _navigate_currency(context);
    } else {
      _navigate_home(context);
    }
  }

  Future<void> _currency_get() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currency_code = prefs.getString('currency_key').toString();
    });
  }

  Future<void> _currency_select() async {
    final prefs = await SharedPreferences.getInstance();
    showCurrencyPicker(
        context: context,
        showFlag: true,
        showCurrencyName: true,
        showCurrencyCode: true,
        onSelect: (Currency currency)  {
          _currency_code = (currency.code);
          setState(() {
            prefs.setString('currency_key', _currency_code);
            _next_Screen();
          },
          );
        });

  }

  void _navigate_currency(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));
  }

  void _navigate_home(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Pree_Bill()));
  }


  @override
  Widget build(BuildContext context) {

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
              "Currency",
              style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Select Currency",style: TextStyle(fontSize: 25.0),),
                SizedBox(height: 20.0,),
                FloatingActionButton(
                  onPressed: (_currency_select),
                  child: Icon(Icons.add,color: Colors.black,),backgroundColor: Colors.blueAccent,),
                SizedBox(height: 20.0,),
                Text(_currency_code,style: TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
        )
    );
  }
}

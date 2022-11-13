import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/pages/model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Price_List extends StatefulWidget {
  List<String> price = [];
  List<String> total = [];
  List<double> quantity = [];
  List <String> slectedItems = [];
  late double totalHome;

  Price_List(
      {required this.price,
      required this.total,
      required this.quantity,
      required this.totalHome,
      required this.slectedItems
      });

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

  void _navigatetoHome(BuildContext context) {
    // navigate to home page
    Navigator.of(context)
        .pop(MaterialPageRoute(builder: (context) => Pree_Bill()));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Model>(context); // provider package object

    void item_Delete(index) {
      // List view builder selected item delete
      setState(() {
        String getTotal = "";
        double checkMinusValue = 0; // plus or minus check value
        if (checkMinusValue >= 0)  {
          widget.price.removeAt(index);
          widget.quantity.removeAt(index);
          getTotal = widget.total.removeAt(index);
          checkMinusValue = widget.totalHome - double.parse(getTotal);
            provider.updateValue(checkMinusValue);
            widget.totalHome = provider.sumTotal;
        }
      });
    }

    Future<void> _showMyDialog(index) async {
      return AwesomeDialog(
              btnCancelColor: Colors.redAccent[700],
              btnOkText: "Remove",
              btnOkColor: Colors.indigoAccent[700],
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.warning,
              body: Center(
                child: Text(
                  "Do you want to deduction this item?",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ),
              btnCancelOnPress: () {
                Navigator.of(context);
              },
              btnOkOnPress: () {
                item_Delete(index);
                Navigator.of(context);
              },
            ).show();
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
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              _navigatetoHome(context);
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
                icon: IconButton(onPressed:(){
                  Navigator.pop(context);
                },icon:Icon(Icons.home,color:Colors.indigoAccent[700],)),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: IconButton(onPressed:(){
                AwesomeDialog(
                  btnCancelColor: Colors.redAccent[700],
                  btnOkText: "Ok",
                  btnOkColor: Colors.indigoAccent[700],
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  body: Center(
                    child: Text(
                      "${_currency_homepage+" "+provider.sumTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                  ),
                  btnOkOnPress: () {
                    Navigator.of(context);
                  },
                ).show();

              },icon:Icon(Icons.info,color: Colors.indigoAccent[700],)),
              label: "",
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: widget.price.length,
              itemBuilder: (BuildContext ctx, index) => Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(30), //border corner radius
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigoAccent[700]),
                                '${widget.slectedItems[index]}',
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Price",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _currency_homepage +
                                          " : " +
                                          widget.price[index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Qty:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      '${widget.quantity[index]}',
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 5.0,
                                              color:
                                                  Colors.indigoAccent.shade700),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton( icon:
                                            Icon(Icons.delete,
                                                    color: Colors
                                                        .indigoAccent[700]),
                                            onPressed: () {
                                              _showMyDialog(index);
                                            }))),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Total",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _currency_homepage +
                                          " : " +
                                          widget.total[index],
                                      style: TextStyle(
                                          fontSize: 15,
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

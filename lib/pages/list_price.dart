import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Price_List extends StatefulWidget {

  List<String> price = [];
  List<String> total = [];
  List<double> quantity = [];
  List<String> status = []; // add or deduction
  int x = 1;

  Price_List( {required this.price,required this.total,required this.quantity, required this.status});

  @override
  State<Price_List> createState() => _Price_ListState();
}

class _Price_ListState extends State<Price_List> {
  final prefs = SharedPreferences;
  String _currency_homepage="";




  @override
  void initState() {
    super.initState();
    currency_assign();
  }

  void item_Delete(index){ // List view builder selected item delete
    setState(() {
      widget.price.removeAt(index);
      widget.total.removeAt(index);
      widget.quantity.removeAt(index);
      widget.status.removeAt(index);
    });
  }

  Future<void> _showMyDialog(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete item',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.indigoAccent[700]),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete this item ?'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No',style: TextStyle(color: Colors.indigoAccent[700]),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes',style: TextStyle(color: Colors.indigoAccent[700]),),
              onPressed: () {
                item_Delete(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void currency_assign()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currency_homepage = prefs.getString('currency_key').toString();
    });
  }


  void _navigatetoHome(BuildContext context){
    Navigator.of(context).pop(MaterialPageRoute(builder: (context)=> Pree_Bill()));
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
              "Price List",
              style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                _navigatetoHome(context);
              },
              icon: Icon(Icons.navigate_before_outlined,color: Colors.black,),
            ),
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
                      borderRadius: BorderRadius.circular(30), //border corner radius
                      boxShadow:[
                        BoxShadow(
                          color: Colors.indigo.shade100.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    //color: Colors.white,
                    child: ListTile(
                    title:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigoAccent[700]),'${widget.status[index]}',),
                          ],
                        ),

                        SizedBox(height: 20.0),

                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                  child: Text("Price",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),)),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_currency_homepage + " : " +widget.price[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Qty:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),)),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),'${widget.quantity[index]}',)),
                            ),
                            Container(

                              width: MediaQuery.of(context).size.width*0.3,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 5.0,
                                          color: Colors.indigo.shade700
                                        ),
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.delete,color: Colors.indigoAccent[700]),
                                        onPressed: () {
                                          //item_Delete(index);
                                          _showMyDialog(index);

                                        },
                                      ))),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Total",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_currency_homepage + " : " +widget.total[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ),
                  ),
                  ),
                ),),
              ),
            ),
        ),
    );
  }
}

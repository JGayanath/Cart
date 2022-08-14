
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/pages/home.dart';
import 'package:pree_bill/pages/select.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools,

      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isloader=false; //change screen

  void initState() {
    super.initState();
    _next_Screen();
  }

  Future<void> _next_Screen()async{ // change screen
    final prefs = await SharedPreferences.getInstance();
    //_currency_code = prefs.getString('currency_key').toString();
    setState(() {
      if (prefs.getString('currency_key')!.isEmpty) {
        isloader = false;
      } else {
        isloader = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigoAccent[700],
      ),
      title: 'Pree Bill',
      home: (isloader) ? Pree_Bill() : Select(),
    );
  }
}

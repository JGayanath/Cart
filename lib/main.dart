
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pree_bill/pages/model.dart';
import 'package:pree_bill/pages/splash.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(

    ChangeNotifierProvider(create: (context)=> Model() , child:  DevicePreview(
      builder: (context) => MyApp(), // Wrap your app
    ),),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigoAccent[700],
      ),
      title: 'Pree Bill',
      home: Splash_Screen(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:pree_bill/model/provider_model/cart_provider.dart';
import 'package:pree_bill/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartModelProvider()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cart',
          home: Splash_Screen(),
        );
      },
    );
  }
}

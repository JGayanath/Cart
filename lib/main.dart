
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:pree_bill/model/model.dart';
import 'package:pree_bill/screens/splash.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(
      ChangeNotifierProvider(create: (context)=> Model() , child:  MyApp()),

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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.appColor,
          ),
          title: 'Cart',
          home: Splash_Screen(),
        );
      },
    );
  }
}

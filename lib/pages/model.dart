

 import 'package:flutter/material.dart';

 class  Model with ChangeNotifier{
   double sumTotal=0.00;
    @override
    updateValue(double sumValue) {
    // TODO: implement notifyListeners
      sumTotal=sumValue;
    super.notifyListeners();
  }
 }


import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/screens/date_filter.dart';
import 'package:pree_bill/screens/home.dart';
import 'package:pree_bill/screens/list_price.dart';
import 'package:pree_bill/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class Main_Screen extends StatefulWidget {
  @override
  _Main_ScreenState createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  int currentPage = 0;
  final List<Widget> _pages = [
    Home(),
    Price_List(),
    BillDate(),
  ];

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67.sp;
    double arcHeightWithNotch = 67.sp;
    DateTime pre_backpress = DateTime.now();

    //statusBar color change
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ));

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.05) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.055) + viewPadding.bottom;
    }

    return WillPopScope(
      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if(cantExit){
          return false;
        }else{
          //not access pop
          SystemNavigator.pop();
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: _pages[currentPage],
          bottomNavigationBar: CircleBottomNavigationBar(
            initialSelection: currentPage,
            barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
            arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
            itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
            itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
            textColor: AppColors.blackColor,
            circleOutline: 10.0.sp,
            shadowAllowance: 0.0,
            circleSize: 30.0.sp,
            blurShadowRadius: 40.0.sp,
            circleColor: Colors.black,
            activeIconColor: AppColors.whiteColor,
            inactiveIconColor: Colors.grey,
            tabs: getTabsData(),
            onTabChangedListener: (index) => setState(() => currentPage = index),
          ),
        ),
      ),
    );
  }
  List<TabData> getTabsData() {
    return [
      TabData(
        icon: Icons.home,
        iconSize: 25.0,
        title: 'Home',
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      TabData(
        icon: Icons.shopping_cart,
        iconSize: 25,
        title: 'Items',
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),

      TabData(
        icon: Icons.save,
        iconSize: 25,
        title: 'Save',
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ];
  }

}
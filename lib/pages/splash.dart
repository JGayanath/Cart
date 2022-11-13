import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pree_bill/pages/home.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Pree_Bill()));
    });
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              duration: Duration(seconds: 3),
                child: Image.asset("assets/images/Pay_drow.png",width: size.width*0.5,height: size.height*0.5,)),
            FadeInDown(
              duration: Duration(seconds: 3),
              child: Text(
                "Pree Bill",
                style:
                TextStyle(fontSize: 35.0, color: Colors.indigoAccent[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

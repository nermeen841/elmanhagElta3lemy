import 'dart:async';
import 'package:elmanhag_app/selectStudentClass/selectStudentClass.dart';
import 'package:flutter/material.dart';

import 'components/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectStudentClassScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#E5E5E5"),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset("assets/images/01 1.png"),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "أكبر موقع إلكتروني يحتوي علي المذكرات و الملازم التي تساعد الطالب وأولياء الأمور ",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

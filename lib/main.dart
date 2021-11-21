import 'package:elmanhag_app/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
          textDirection: TextDirection.rtl, child: SplashScreen()),
    );
  }
}

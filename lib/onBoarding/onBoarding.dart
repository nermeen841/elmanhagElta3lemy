import 'package:elmanhag_app/components/size_config.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class OnBoardingScreen extends StatefulWidget {
  static String routeName = "/onBoarding";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   bool onBording = false;

//   getOnBoarding() async {
//     SharedPreferences _sp = await SharedPreferences.getInstance();
//     setState(() {
//       onBording = _sp.getBool("onBoearding") ?? false;
//     });
//   }

//   @override
//   void initState() {
//     this.getOnBoarding();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (onBording == true) {
//       return CustomBottomNav(screenIndex: 0);
//     } else {
//       return OnBoard();
//     }
//   }
// }

// class OnBoard extends StatefulWidget {
//   @override
//   _OnBoardState createState() => _OnBoardState();
// }

// class _OnBoardState extends State<OnBoard> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: Directionality(textDirection: TextDirection.rtl, child: Body()),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Directionality(textDirection: TextDirection.rtl, child: Body()),
    );
  }
}

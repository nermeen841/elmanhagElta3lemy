import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/components/default_button.dart';
import 'package:elmanhag_app/components/size_config.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatefulWidget {
  final String text;
  final String image;

  const SplashContent({Key? key, required this.text, required this.image})
      : super(key: key);

  @override
  _SplashContentState createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Image.asset(
          widget.image,
          height: getProportionateScreenHeight(350),
          width: getProportionateScreenWidth(400),
          fit: BoxFit.cover,
        ),
        spaceH(20),
        SizedBox(
          height: 65,
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: headingStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        spaceH(20),
        SizedBox(
          width: 200,
          child: DefaultButton(
              text: "ابدء رحلتك الأن",
              press: () async {
                // SharedPreferences _sp = await SharedPreferences.getInstance();
                // _sp.setBool("onBoearding", true);

                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => CustomBottomNav(
                //               screenIndex: 0,
                //             )));
              }),
        ),
      ],
    );
  }
}

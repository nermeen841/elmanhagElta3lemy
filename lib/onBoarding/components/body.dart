import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'onBoarding_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "طور ذاتك", "image": "assets/images/17.jpg"},
    {"text": "اكتسب عاده جديده", "image": "assets/images/2.jpg"},
    {"text": "ماذا تنتظر ", "image": "assets/images/3.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Spacer(),
              Expanded(
                flex: 7,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: PageView.builder(
                    onPageChanged: (value) async {
                      setState(() {
                        currentPage = value;
                      });
                      // SharedPreferences _sp =
                      //     await SharedPreferences.getInstance();
                      // _sp.setBool("onBoearding", true);
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]['image'].toString(),
                      text: splashData[index]['text'].toString(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Spacer(),
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 14,
      width: currentPage == index ? 14 : 14,
      decoration: BoxDecoration(
        color: currentPage == index ? HexColor("#898A8D") : HexColor("#C4C4C4"),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  getProportionateScreenWidth(int i) {}
}

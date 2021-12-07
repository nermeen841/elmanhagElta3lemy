import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/homeScreen/homeScreen.dart';
import 'package:elmanhag_app/notificationSetting.dart/notificationSetting.dart';
import 'package:elmanhag_app/selectStudentClass/selectStudentClass.dart';
import 'package:flutter/material.dart';

class MenueItem extends StatefulWidget {
  @override
  _MenueItemState createState() => _MenueItemState();
}

class _MenueItemState extends State<MenueItem> {
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }

  String? getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6460577785255164/6757169449';
    }
    return null;
  }

  @override
  void initState() {
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    interstitialAd.load();

    super.initState();
  }

  @override
  void dispose() {
    interstitialAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        elevation: 0.0,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              width: 130,
              height: 60,
              child: DrawerHeader(
                  child: Center(
                child: Image.asset(
                  "assets/images/logo2021-2.png",
                  fit: BoxFit.cover,
                ),
              )),
            ),
            Container(
              color: Colors.white,
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.house,
                      color: HexColor("#323232"),
                    ),
                    onTap: () {
                      interstitialAd.show();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    title: Text(
                      "الرئيسية",
                      style: headingStyle.copyWith(
                          color: HexColor("#323232"),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      interstitialAd.show();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectClass()));
                    },
                    leading: Icon(
                      Icons.person_add,
                      color: HexColor("#323232"),
                    ),
                    title: Text(
                      "إعدادات الصفوف المفضلة",
                      style: headingStyle.copyWith(
                          color: HexColor("#323232"),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      interstitialAd.show();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifySettingScreen()));
                    },
                    leading: Icon(
                      Icons.date_range,
                      color: HexColor("#323232"),
                    ),
                    title: Text(
                      "تنبيهات مواعيد المذاكرة",
                      style: headingStyle.copyWith(
                          color: HexColor("#323232"),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "تنفيذ شركة تكنو مصر للبرمجيات",
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#175798")),
                    ),
                    spaceH(10),
                    Text(
                      "www.technomasr.com",
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#175798")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

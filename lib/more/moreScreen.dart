import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/homeScreen/componnent/menue.dart';
import 'package:elmanhag_app/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';
import 'componnent/listPagination.dart';

class MoreScreen extends StatefulWidget {
  final String sectionId;
  final String sectiontitle;
  final String sectionDesc;

  const MoreScreen(
      {Key? key,
      required this.sectionId,
      required this.sectiontitle,
      required this.sectionDesc})
      : super(key: key);
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;
  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();

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
      return 'ca-app-pub-7628520504990427/4296100598';
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: HexColor("#F1F1F1"),
      endDrawer: MenueItem(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: InkWell(
          onTap: () {
            // interstitialAd.show();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          },
          child: Image.asset(
            "assets/images/logo2021-2.png",
            width: 130,
            height: 60,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
              icon: Icon(
                Icons.format_align_justify,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80),
        child: SpeedDial(
          overlayColor: HexColor("#323232"),
          backgroundColor: HexColor("#3080D1"),
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          childPadding: EdgeInsets.all(10),
          spaceBetweenChildren: 4,
          dialRoot: customDialRoot
              ? (ctx, open, toggleChildren) {
                  return ElevatedButton(
                    onPressed: toggleChildren,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                    ),
                    child: Text(
                      "Custom Dial Root",
                      style: TextStyle(fontSize: 17),
                    ),
                  );
                }
              : null,
          buttonSize: 56,
          label: extend ? Text("Open") : null,
          activeLabel: extend ? Text("Close") : null,
          childrenButtonSize: 56.0,
          visible: visible,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,
          closeManually: closeManually,
          renderOverlay: renderOverlay,
          useRotationAnimation: useRAnimation,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          elevation: 0.0,
          isOpenOnStart: false,
          animationSpeed: 200,
          childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            SpeedDialChild(
              labelStyle: headingStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              // child:
              //     !rmicons ? Icon(Icons.check_circle_outline_outlined) : null,
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.black,
              foregroundColor: Colors.black,
              label: 'اطلب المذكرة',
              onTap: () {
                launch("https://m.me/elmanhg");
              },
            ),
            SpeedDialChild(
              labelStyle: headingStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.black,
              foregroundColor: Colors.black,
              label: 'جروب المنهج التعليمي',
              onTap: () {
                launch("https://www.facebook.com/groups/229673250760836");
              },
            ),
            SpeedDialChild(
              labelStyle: headingStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.black,
              foregroundColor: Colors.black,
              label: 'صفحتنا علي الفيسبوك',
              onTap: () {
                launch("https://www.facebook.com/elmanhg/");
              },
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: MoreListpagination(
            sectionId: widget.sectionId,
            sectionDesc: widget.sectionDesc,
            sectiontitle: widget.sectiontitle,
          )
          // MoreBody(
          //   sectionId: widget.sectionId,
          // ),
          ),
    );
  }
}

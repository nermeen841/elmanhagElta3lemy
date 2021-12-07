import 'dart:io';
import 'dart:ui';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/details/detailScreen.dart';
import 'package:flutter/material.dart';

class LessonCardlist extends StatefulWidget {
  final String title;
  final String image;
  final String itemId;
  final String itemDesc;

  const LessonCardlist(
      {Key? key,
      required this.title,
      required this.image,
      required this.itemId,
      required this.itemDesc})
      : super(key: key);
  @override
  _LessonCardlistState createState() => _LessonCardlistState();
}

class _LessonCardlistState extends State<LessonCardlist> {
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
    return InkWell(
      onTap: () {
        interstitialAd.show();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      itemId: widget.itemId,
                    )));
      },
      child: Container(
        // height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: HexColor("#E6EEF7"),
                  offset: Offset(0, 3),
                  blurRadius: 3,
                  spreadRadius: 3)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Container(
                width: 110,
                // height: 150,
                child: customCachedNetworkImage(
                    url: widget.image,
                    context: context,
                    fit: BoxFit.fitHeight)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.title,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: headingStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#323232")),
                    ),
                  ),
                  spaceH(10),
                  SizedBox(
                    width: 200,
                    child: Text(
                      parseHtmlString(widget.itemDesc),
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: headingStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  customCachedNetworkImage({
    required String url,
    required context,
    required BoxFit fit,
  }) {
    try {
      // ignore: unnecessary_null_comparison
      if (url == null || url == "") {
        return Container(
          child: Image.asset(
            "assets/images/logo2021.png",
            height: 100,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.contain,
          ),
        );
      } else {
        return Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: (Uri.parse(url).isAbsolute)
              ? CachedNetworkImage(
                  imageUrl: url,
                  fit: fit,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/images/logo2021.png",
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                    );
                  })
              : Image.asset(
                  "assets/images/logo2021.png",
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

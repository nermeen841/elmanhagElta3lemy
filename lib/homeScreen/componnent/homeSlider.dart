import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/controller/home_Ads.dart';
import 'package:elmanhag_app/details/detailScreen.dart';
import 'package:elmanhag_app/homeScreen/componnent/sectionTitle.dart';
import 'package:elmanhag_app/homeScreen/componnent/slidermore_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
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
    return FutureBuilder(
        future: getHomeAds(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  SectionTtile(
                    title: "أحدث الإضافات",
                    press: () {
                      interstitialAd.show();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdsMore()),
                      );
                    },
                  ),
                  spaceH(10),
                  CarouselSlider.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index, pageViewIndex) {
                      return InkWell(
                        onTap: () {
                          interstitialAd.show();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      itemId: '${snapshot.data[index]['id']}',
                                    )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: customCachedNetworkImage(
                              context: context,
                              title:
                                  "${snapshot.data[index]['title']['rendered']}",
                              url:
                                  "${snapshot.data[index]['x_featured_media_medium']}",
                              fit: BoxFit.cover),

                          // Image.asset(
                          //   images[index],
                          //   height: 250,
                          //   fit: BoxFit.contain,
                          // ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 250,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

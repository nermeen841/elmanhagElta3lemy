import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/DBhelper/AppCubit/databaseCubite.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/homeScreen/componnent/homeSlider.dart';
import 'package:elmanhag_app/homeScreen/componnent/lessonscard.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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

  @override
  void initState() {
    bannerSize = AdmobBannerSize.BANNER;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      physics: BouncingScrollPhysics(),
      children: [
        HomeSlider(),
        spaceH(20),
        Container(
          child: AdmobBanner(
            adUnitId: getBannerAdUnitId()!,
            adSize: bannerSize!,
            listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
              handleEvent(event, args, 'Banner');
            },
            onBannerCreated: (AdmobBannerController controller) {},
          ),
        ),
        spaceH(20),
        Container(
          child: ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) => LessonsCard(
                    title: DataBaseCubit.get(context)
                        .sectiondata[index]['sectionTitle']
                        .toString(),
                    sectionId: DataBaseCubit.get(context)
                        .sectiondata[index]['sectionId']
                        .toString(),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: DataBaseCubit.get(context).sectiondata.length),
        )
      ],
    );
  }

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'a-app-pub-4856073639039057/3594958715';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6460577785255164/7359804675';
    }
    return null;
  }
}

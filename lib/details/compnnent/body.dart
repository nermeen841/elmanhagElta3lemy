import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/controller/detailscreen%20data.dart';
import 'package:flutter/material.dart';

import 'description.dart';
import 'downloadContainer.dart';

class DetailBody extends StatefulWidget {
  final String itemId;
  const DetailBody({Key? key, required this.itemId}) : super(key: key);

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
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
    return FutureBuilder(
        future: getdetailData(id: widget.itemId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              physics: BouncingScrollPhysics(),
              children: [
                (snapshot.data['x_featured_media_medium'] != null)
                    ? Container(
                        height: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${snapshot.data['x_featured_media_medium']}"),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                  color: HexColor("#E6EEF7"),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                  spreadRadius: 3)
                            ]),
                      )
                    : Container(),
                spaceH(15),
                Text(
                  "${snapshot.data['title']['rendered']}",
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: headingStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#323232")),
                ),
                spaceH(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: HexColor("#666666"),
                      size: 20,
                    ),
                    spaceW(5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "${snapshot.data['x_date']}",
                        textDirection: TextDirection.rtl,
                        style: headingStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#666666")),
                      ),
                    ),
                    spaceW(30),
                    Icon(
                      Icons.create,
                      color: HexColor("#666666"),
                      size: 20,
                    ),
                    spaceW(5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "${snapshot.data['x_author']}",
                        textDirection: TextDirection.rtl,
                        style: headingStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#666666")),
                      ),
                    ),
                  ],
                ),
                spaceH(20),
                Descriptiondata(
                  descripotion: '${snapshot.data['content']['rendered']}',
                ),
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
                spaceH(15),
                Downloaddetail(
                  title: '${snapshot.data['filetitle']}',
                  itemsize: '${snapshot.data['filesize']}',
                  itemtype: '${snapshot.data['filetype']}',
                  itemUrl: '${snapshot.data['fileurl']}',
                )
              ],
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

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'a-app-pub-4856073639039057/3594958715';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6460577785255164/7359804675';
    }
    return null;
  }
}

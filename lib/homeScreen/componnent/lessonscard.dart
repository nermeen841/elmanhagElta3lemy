import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/controller/classesAPI.dart';
import 'package:elmanhag_app/cubit/app_cubit.dart';
import 'package:elmanhag_app/cubit/app_state.dart';
import 'package:elmanhag_app/homeScreen/componnent/sectionTitle.dart';
import 'package:elmanhag_app/more/moreScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsCard extends StatefulWidget {
  final String title;
  final String sectionId;
  const LessonsCard({Key? key, required this.title, required this.sectionId})
      : super(key: key);

  @override
  _LessonsCardState createState() => _LessonsCardState();
}

class _LessonsCardState extends State<LessonsCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List data = [];
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
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
  void dispose() {
    interstitialAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTtile(
              title: widget.title,
              press: () {
                interstitialAd.show();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoreScreen(
                            sectionId: widget.sectionId,
                            sectionDesc: '',
                            sectiontitle: widget.title,
                          )),
                );
              }),
          spaceH(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              termsList(),
              spaceH(20),
              (data.isNotEmpty)
                  ? Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                          controller: _tabController,
                          children: List.generate(2, (index) => lessonsList())),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  termsList() {
    return FutureBuilder(
        future: getgrades(sectionId: widget.sectionId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data.isNotEmpty)
                ? Container(
                    height: 40,
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        AppCubite.get(context)
                            .changeId(id: "${snapshot.data[index]['id']}");
                        setState(() {
                          data.addAll(snapshot.data);
                        });
                      },
                      isScrollable: true,
                      labelColor: HexColor("#3080D1"),
                      labelStyle: headingStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: headingStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: List.generate(
                        snapshot.data.length,
                        (index) => Text(
                          "${snapshot.data[index]['name']}",
                        ),
                      ),
                    ),
                  )
                : Container();
          } else {
            return Container();
          }
        });
  }

  lessonsList() {
    return BlocConsumer<AppCubite, AppCubiteStates>(
        builder: (context, state) {
          return (AppCubite.get(context).lessonId != '')
              ? FutureBuilder(
                  future: getgrades(sectionId: AppCubite.get(context).lessonId),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data.isNotEmpty)
                          ? Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListView.separated(
                                  primary: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        interstitialAd.show();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MoreScreen(
                                                  sectionDesc:
                                                      "${snapshot.data[index]['description']}",
                                                  sectiontitle:
                                                      "${snapshot.data[index]['name']}",
                                                  sectionId:
                                                      "${snapshot.data[index]['id']}")),
                                        );
                                      },
                                      child: Container(
                                        width: 90,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: HexColor("#E6EEF7"),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: Text(
                                              "${snapshot.data[index]['name']}",
                                              style: headingStyle.copyWith(
                                                  color: HexColor("#323232"),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        width: 10,
                                      ),
                                  itemCount: snapshot.data.length),
                            )
                          : Container();
                    } else {
                      return Container();
                    }
                  })
              : Container();
        },
        listener: (context, state) {});
  }
}

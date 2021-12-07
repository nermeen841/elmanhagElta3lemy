import 'dart:convert';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/httpServices/endpoints.dart';
import 'package:elmanhag_app/more/componnent/listcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoreListpagination extends StatefulWidget {
  final String sectionId;
  final String sectiontitle;
  final String sectionDesc;
  const MoreListpagination(
      {Key? key,
      required this.sectionId,
      required this.sectiontitle,
      required this.sectionDesc})
      : super(key: key);

  @override
  _MoreListpaginationState createState() => _MoreListpaginationState();
}

class _MoreListpaginationState extends State<MoreListpagination> {
  int _page = 1;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    print(
        "------------------------------------------------ ${widget.sectionId}");
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(Uri.parse(EndPoints.BASEURL +
          "/posts?categories=${widget.sectionId}&per_page=10&orderby=id&order=desc&page=$_page"));
      var finalRes = json.decode(res.body);
      setState(() {
        _posts = finalRes;
      });
    } catch (err) {}

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 100) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await http.get(Uri.parse(EndPoints.BASEURL +
            "/posts?categories=${widget.sectionId}&per_page=10&orderby=id&order=desc&page=$_page"));

        var response = json.decode(res.body);

        if (response.length > 0) {
          setState(() {
            _posts.addAll(response);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {}

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

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
    super.initState();
    _firstLoad();
    bannerSize = AdmobBannerSize.BANNER;

    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: (_isFirstLoadRunning)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    widget.sectiontitle,
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: HexColor("#323232")),
                  ),
                  // ignore: unnecessary_null_comparison
                  (widget.sectionDesc != null)
                      ? Text(
                          parseHtmlString(widget.sectionDesc),
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          maxLines: 3,
                          style: headingStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: HexColor("#666666")),
                        )
                      : Container(),

                  Container(
                    child: AdmobBanner(
                      adUnitId: getBannerAdUnitId()!,
                      adSize: bannerSize!,
                      listener:
                          (AdmobAdEvent event, Map<String, dynamic>? args) {
                        handleEvent(event, args, 'Banner');
                      },
                      onBannerCreated: (AdmobBannerController controller) {},
                    ),
                  ),

                  (_posts.isNotEmpty)
                      ? Expanded(
                          child: ListView.separated(
                            controller: _controller,
                            // shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _posts.length,
                            itemBuilder: (context, index) {
                              return LessonCardlist(
                                image:
                                    "${_posts[index]['x_featured_media_medium']}",
                                title: "${_posts[index]['filetitle']}",
                                itemId: "${_posts[index]['id']}",
                                itemDesc:
                                    "${_posts[index]['excerpt']['rendered']}",
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 10),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            children: [
                              Image.asset(
                                "assets/images/3973481.jpg",
                                fit: BoxFit.cover,
                              ),
                              spaceH(15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "لا توجد مذكرات في الوقت الحالي",
                                  textAlign: TextAlign.center,
                                  style: headingStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red[900]),
                                ),
                              )
                            ],
                          ),
                        ),

                  // when the _loadMore function is running
                  if (_isLoadMoreRunning == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'لقد وصلت للحد الأقصي',
                          style: headingStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: HexColor("#3080D1")),
                        ),
                      ),
                    ),
                ],
              ));
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

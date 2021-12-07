import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Downloaddetail extends StatelessWidget {
  final String title;
  final String itemsize;
  final String itemtype;
  final String itemUrl;
  const Downloaddetail(
      {Key? key,
      required this.title,
      required this.itemsize,
      required this.itemtype,
      required this.itemUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 115,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: HexColor("#3080D1")),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: HexColor("#E6EEF7"),
                offset: Offset(0, 3),
                blurRadius: 3,
                spreadRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: HexColor("#3080D1")),
            child: Center(
              child: Text(
                "معلومات القراءة و التحميل",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: headingStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        "اسم الملف : $title",
                        textAlign: TextAlign.start,
                        maxLines: 4,
                        textDirection: TextDirection.rtl,
                        style: headingStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      "حجم الملف : $itemsize",
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: headingStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      "صيغة الملف : $itemtype",
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: headingStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    launch(itemUrl);
                  },
                  child: Container(
                    width: 80,
                    // height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: HexColor("#F06F9E")),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.cloud_download,
                          color: Colors.white,
                          size: 40,
                        ),
                        spaceH(5),
                        Text(
                          "اضغط هنا",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: headingStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:elmanhag_app/DBhelper/alarm_notifiy.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/cubit/app_state.dart';
import 'package:elmanhag_app/homeScreen/homeScreen.dart';
import 'package:elmanhag_app/notificationSetting.dart/componnent/timeSelection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifyBody extends StatefulWidget {
  @override
  _NotifyBodyState createState() => _NotifyBodyState();
}

class _NotifyBodyState extends State<NotifyBody> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AlarmNotify, AppCubiteStates>(
          builder: (context, state) {
            return ListView(
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: 152,
                      height: 80,
                      child: Image.asset(
                        "assets/images/logo2021-2.png",
                        fit: BoxFit.contain,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "اختر توقيت المذاكرة الملائم لك",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Khebrat Musamim'),
                  ),
                ),
                Center(
                    child: Text(
                        "(تساعدك التنبيهات على إدارة وقت المذاكرة الخاص بك )",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Khebrat Musamim',
                            fontWeight: FontWeight.w400,
                            color: Colors.black54))),
                SizedBox(
                  height: 20,
                ),
                if (AlarmNotify.get(context).notifyData.isNotEmpty)
                  Container(
                    child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                textDirection: TextDirection.rtl,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.expand_more,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  spaceW(10),
                                  Text(
                                    "${AlarmNotify.get(context).notifyData[index]['day']}",
                                    style: headingStyle.copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    AlarmNotify.get(context).deletaFromDB(
                                        notifyId: AlarmNotify.get(context)
                                            .notifyData[index]['id']);
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: HexColor("#3080D1")
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: HexColor("#3080D1"))),
                                    child: Center(
                                      child: Text(
                                        "${AlarmNotify.get(context).notifyData[index]['time']}",
                                        textDirection: TextDirection.ltr,
                                        style: headingStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor("#3080D1")),
                                      ),
                                    ),
                                  )),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => spaceH(20),
                        itemCount: AlarmNotify.get(context).notifyData.length),
                  )
                else
                  Container(),
                spaceH(10),
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 50,
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              color: HexColor("#3080D1"),
                              onPressed: () {
                                showMyDialog(
                                    context: context,
                                    title: '',
                                    data: TimeSelectionScreen());
                              },
                              child: Row(
                                textDirection: TextDirection.rtl,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  spaceW(10),
                                  Text(
                                    "اضف وقت جديد للتنبيه",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Khebrat Musamim',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setBool('skip_time', true);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                "تخطي",
                                style: headingStyle.copyWith(
                                    color: HexColor("#999999"),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      )),
                )
              ],
            );
          },
          listener: (context, state) {}),
    );
  }
}

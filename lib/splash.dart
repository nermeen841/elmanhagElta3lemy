import 'dart:async';
import 'package:elmanhag_app/selectStudentClass/selectStudentClass.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'DBhelper/alarm_notifiy.dart';
import 'components/constants.dart';
import 'homeScreen/homeScreen.dart';
import 'package:elmanhag_app/DBhelper/AppCubit/databaseCubite.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Widget screen;

  getfirstScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final skipTimeScreen = preferences.getBool('skip_time')!;
    final slectclassScreen = preferences.getBool('select_class')!;

    if (skipTimeScreen == true) {
      setState(() {
        screen = HomeScreen();
      });
    } else if (slectclassScreen == true) {
      setState(() {
        screen = HomeScreen();
      });
    } else {
      setState(() {
        screen = SelectStudentClassScreen();
      });
    }
  }

  @override
  void initState() {
    this.getfirstScreen();
    DataBaseCubit.get(context).createDb();
    AlarmNotify.get(context).createDb2();
    getNotifyAlarm(context);
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectStudentClassScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#E5E5E5"),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset("assets/images/01 1.png"),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "أكبر موقع إلكتروني يحتوي علي المذكرات و الملازم التي تساعد الطالب وأولياء الأمور ",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Khebrat Musamim',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

getNotifyAlarm(BuildContext context) async {
  late AndroidNotificationChannel channel;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  for (var item in AlarmNotify.get(context).notifyData) {
    {
      // ignore: deprecated_member_use
      flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
          0,
          'المنهج التعليمي',
          'حان وقت المذاكرة',
          item['day'],
          item['time'],
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
                importance: Importance.high),
          ));
    }
  }
}

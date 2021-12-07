import 'package:admob_flutter/admob_flutter.dart';
import 'package:elmanhag_app/DBhelper/AppCubit/databaseCubite.dart';
import 'package:elmanhag_app/cubit/app_cubit.dart';
import 'package:elmanhag_app/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'DBhelper/alarm_notifiy.dart';

late AndroidNotificationChannel channel;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    flutterLocalNotificationsPlugin.show(
        0,
        "المنهج التعليمي",
        'time for learnning',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
            importance: Importance.high,
          ),
        ));
    // ignore: deprecated_member_use
    flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'المنهج التعليمي',
        'time for learnning',
        Day.tuesday,
        Time(1),
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
              importance: Importance.high),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppCubite>(create: (context) => AppCubite()),
          BlocProvider<DataBaseCubit>(
              create: (context) => DataBaseCubit()..createDb()),
          BlocProvider<AlarmNotify>(
              create: (context) => AlarmNotify()..createDb2()),
        ],
        child: MaterialApp(
          home: Directionality(
              textDirection: TextDirection.rtl, child: SplashScreen()),
        ));
  }
}

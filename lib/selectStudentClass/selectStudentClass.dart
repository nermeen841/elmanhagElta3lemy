import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/homeScreen/homeScreen.dart';
import 'package:elmanhag_app/notificationSetting.dart/notificationSetting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'componnent/body.dart';

class SelectStudentClassScreen extends StatefulWidget {
  @override
  _SelectStudentClassScreenState createState() =>
      _SelectStudentClassScreenState();
}

class _SelectStudentClassScreenState extends State<SelectStudentClassScreen> {
  late Widget screen;
  bool skipTimeScreen = false;
  bool slectclassScreen = false;

  getfirstScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    skipTimeScreen = preferences.getBool('skip_time')!;
    slectclassScreen = preferences.getBool('select_class')!;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (slectclassScreen == true) {
      if (skipTimeScreen == true) {
        return HomeScreen();
      } else {
        return NotifySettingScreen();
      }
    } else {
      return SelectClass();
    }
  }
}

class SelectClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#E5E5E5"),
        appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: HexColor("#E5E5E5"),
        ),
        body: SelectClassBody());
  }
}

import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';

import 'componnent/body.dart';

class NotifySettingScreen extends StatefulWidget {
  @override
  _NotifySettingScreenState createState() => _NotifySettingScreenState();
}

class _NotifySettingScreenState extends State<NotifySettingScreen> {
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
      body: NotifyBody(),
    );
  }
}

import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';

import 'componnent/body.dart';

class SelectStudentClassScreen extends StatefulWidget {
  const SelectStudentClassScreen({Key? key}) : super(key: key);

  @override
  _SelectStudentClassScreenState createState() =>
      _SelectStudentClassScreenState();
}

class _SelectStudentClassScreenState extends State<SelectStudentClassScreen> {
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

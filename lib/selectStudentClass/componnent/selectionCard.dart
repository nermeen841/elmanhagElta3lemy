import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  const SelectionCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: HexColor("#323232"))),
      child: RadioListTile(
        groupValue: "",
        value: "",
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor("#323232")),
        ),
        onChanged: (String? value) {},
      ),
    );
  }
}

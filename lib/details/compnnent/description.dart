import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';

class Descriptiondata extends StatefulWidget {
  final String descripotion;

  const Descriptiondata({Key? key, required this.descripotion})
      : super(key: key);
  @override
  _DescriptiondataState createState() => _DescriptiondataState();
}

class _DescriptiondataState extends State<Descriptiondata> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: HexColor("#E6EEF7"),
                offset: Offset(0, 3),
                blurRadius: 3,
                spreadRadius: 3)
          ]),
      child: Text(
        parseHtmlString(widget.descripotion),
        textAlign: TextAlign.start,
        style: headingStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HexColor("#666666")),
      ),
    );
  }
}

import 'package:elmanhag_app/components/constants.dart';
import 'package:flutter/material.dart';

class SectionTtile extends StatelessWidget {
  final String title;
  final VoidCallback press;

  const SectionTtile({Key? key, required this.title, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 30,
            ),
            spaceW(5),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                title,
                style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
              ),
            )
          ],
        ),
        Spacer(),
        InkWell(
          onTap: press,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.add,
                color: HexColor("#3080D1"),
                size: 30,
              ),
              spaceW(5),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "كل الملازم و المذكرات",
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: HexColor("#3080D1"),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

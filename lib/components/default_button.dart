import 'package:flutter/material.dart';
import 'constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      // ignore: deprecated_member_use
      child: FlatButton(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: HexColor("#3080D1"),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

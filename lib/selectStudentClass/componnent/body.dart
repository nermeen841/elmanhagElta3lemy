import 'package:elmanhag_app/components/default_button.dart';
import 'package:elmanhag_app/selectStudentClass/componnent/selectionCard.dart';
import 'package:flutter/material.dart';

class SelectClassBody extends StatefulWidget {
  const SelectClassBody({Key? key}) : super(key: key);

  @override
  _SelectClassBodyState createState() => _SelectClassBodyState();
}

class _SelectClassBodyState extends State<SelectClassBody> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
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
              "اختر الصفوف التي ترغب في دراستها",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
              child: Text("(يمكنك اختيار أكثر من صف )",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54))),
          SizedBox(
            height: 20,
          ),
          SelectionCard(
            title: "الصف الأول الإبتدائي",
          ),
          SizedBox(
            height: 20,
          ),
          SelectionCard(
            title: "الصف الثاني الإبتدائي",
          ),
          SizedBox(
            height: 20,
          ),
          SelectionCard(
            title: "الصف الثالث الإبتدائي",
          ),
          SizedBox(
            height: 20,
          ),
          SelectionCard(
            title: "الصف الرابع الإبتدائي",
          ),
          SizedBox(
            height: 20,
          ),
          SelectionCard(
            title: "الصف الخامس الإبتدائي",
          ),
          SizedBox(
            height: 20,
          ),
          SelectionCard(
            title: "الصف السادس الإبتدائي",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DefaultButton(
                text: "تأكيد ابدء تصفح المذكرات الان",
                press: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

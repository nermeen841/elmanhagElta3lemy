import 'package:elmanhag_app/DBhelper/alarm_notifiy.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/components/default_button.dart';
import 'package:elmanhag_app/cubit/app_cubit.dart';
import 'package:elmanhag_app/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeSelectionScreen extends StatefulWidget {
  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  List<String> daysList = [
    "السبت",
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعه"
  ];
  List<String> timeList5 = [
    "00 : 00",
    "12 : 00",
    "1 : 00",
    "2 : 00",
    "3 : 00",
    "4 : 00",
    "5 : 00",
    "6 : 00",
    "7 : 00",
    "8 : 00",
    "9 : 00",
    "10 : 00",
    "11 : 00",
    "12 : 00",
    "13 : 00",
    "14 : 00",
    "15 : 00",
    "16 : 00",
    "17 : 00",
    "18 : 00",
    "19 : 00",
    "20 : 00",
    "21 : 00",
    "22 : 00",
    "23 : 00",
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<AppCubite, AppCubiteStates>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              primary: true,
              shrinkWrap: true,
              children: [
                Text(
                  "اليوم",
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: headingStyle.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                spaceH(20),
                InkWell(
                  onTap: () {
                    _showPopupMenudate();
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor("#F1F1F1"),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                          child: Text(
                            AppCubite.get(context).dayselected.toString(),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: headingStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#666666")),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceH(20),
                Text(
                  "الساعه",
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: headingStyle.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                spaceH(20),
                InkWell(
                  onTap: () {
                    _showPopupMenu();
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor("#F1F1F1"),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                          child: Text(
                            AppCubite.get(context).timeselected.toString(),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style: headingStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#666666")),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceH(20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(right: 50, left: 50),
                    child: DefaultButton(
                      press: () {
                        AlarmNotify.get(context).inserttoDatabase2(
                            day: AppCubite.get(context).dayselected,
                            time: AppCubite.get(context).timeselected);
                        Navigator.pop(context);
                      },
                      text: 'إضافة',
                    ),
                  ),
                )
              ],
            );
          },
          listener: (context, state) {},
        ));
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 380, 100, 200),
      items: timeList5.map((String choice) {
        return PopupMenuItem(
          value: choice,
          child: InkWell(
            onTap: () {
              AppCubite.get(context).changetime(updatedTime: choice.toString());
              Navigator.pop(context);
            },
            child: Text(
              "$choice",
              style: headingStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
      elevation: 8.0,
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////

  void _showPopupMenudate() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 250, 100, 200),
      items: daysList.map((String choice) {
        return PopupMenuItem(
          value: choice,
          child: InkWell(
            onTap: () {
              AppCubite.get(context).changeday(updatedDay: choice.toString());
              Navigator.pop(context);
            },
            child: Text(
              "$choice",
              style: headingStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
      elevation: 8.0,
    );
  }
}

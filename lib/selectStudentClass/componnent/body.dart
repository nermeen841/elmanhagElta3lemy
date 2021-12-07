import 'package:elmanhag_app/DBhelper/AppCubit/databaseCubite.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/components/default_button.dart';
import 'package:elmanhag_app/controller/classesAPI.dart';
import 'package:elmanhag_app/notificationSetting.dart/notificationSetting.dart';
import 'package:elmanhag_app/selectStudentClass/componnent/selectionCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectClassBody extends StatefulWidget {
  const SelectClassBody({Key? key}) : super(key: key);

  @override
  _SelectClassBodyState createState() => _SelectClassBodyState();
}

class _SelectClassBodyState extends State<SelectClassBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getClasses(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                primary: true,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Khebrat Musamim'),
                    ),
                  ),
                  Center(
                      child: Text("(يمكنك اختيار أكثر من صف )",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Khebrat Musamim',
                              fontWeight: FontWeight.w400,
                              color: Colors.black54))),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, index) {
                          return spaceH(40);
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                snapshot.data[index]['name'].toString() + ":",
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.rtl,
                                style: headingStyle.copyWith(
                                    color: HexColor("#3080D1"), fontSize: 25),
                              ),
                              spaceH(10),
                              SelectionCard(
                                sectionId:
                                    snapshot.data[index]['id'].toString(),
                                sectiontitle:
                                    snapshot.data[index]['name'].toString(),
                              )
                            ],
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: DefaultButton(
                        text: "تأكيد ابدء تصفح المذكرات الان",
                        press: () async {
                          if (DataBaseCubit.get(context)
                              .sectiondata
                              .isNotEmpty) {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setBool('select_class', true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotifySettingScreen()));
                          } else {
                            showMyDialog(
                                context: context,
                                title: "",
                                data: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.black,
                                          size: 30,
                                        )),
                                    spaceH(20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 60),
                                      child: Image.asset(
                                        "assets/images/select.png",
                                        fit: BoxFit.contain,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(
                                        "يجب اختيار المرحله التعليمية",
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        style: headingStyle.copyWith(
                                            color: Colors.red[900],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ));
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

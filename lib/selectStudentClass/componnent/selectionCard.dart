import 'package:elmanhag_app/DBhelper/AppCubit/databaseCubite.dart';
import 'package:elmanhag_app/components/constants.dart';
import 'package:elmanhag_app/controller/classesAPI.dart';
import 'package:elmanhag_app/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCard extends StatelessWidget {
  final String sectionId;
  final String sectiontitle;
  const SelectionCard(
      {Key? key, required this.sectionId, required this.sectiontitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataBaseCubit, AppCubiteStates>(
        builder: (context, state) {
          return FutureBuilder(
              future: getgrades(sectionId: sectionId),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return Container(
                        child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            separatorBuilder: (context, index) {
                              return spaceH(20);
                            },
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (DataBaseCubit.get(context).isselected[
                                          "${snapshot.data[index]['id']}"] ==
                                      true) {
                                    DataBaseCubit.get(context).deletaFromDB(
                                        sectionID:
                                            "${snapshot.data[index]['id']}");
                                  } else {
                                    DataBaseCubit.get(context).inserttoDatabase(
                                        sectionTitle:
                                            "${snapshot.data[index]['name']}",
                                        sectionID:
                                            "${snapshot.data[index]['id']}");
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: (DataBaseCubit.get(context)
                                                      .isselected[
                                                  "${snapshot.data[index]['id']}"] ==
                                              true)
                                          ? HexColor("#3080D1").withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: (DataBaseCubit.get(context)
                                                        .isselected[
                                                    "${snapshot.data[index]['id']}"] ==
                                                true)
                                            ? HexColor("#3080D1")
                                            : HexColor("#323232"),
                                      )),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: (DataBaseCubit.get(context)
                                                              .isselected[
                                                          "${snapshot.data[index]['id']}"] ==
                                                      true)
                                                  ? HexColor("#3080D1")
                                                  : HexColor("#323232"),
                                            )),
                                        child: (DataBaseCubit.get(context)
                                                        .isselected[
                                                    "${snapshot.data[index]['id']}"] ==
                                                true)
                                            ? Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: HexColor("#3080D1")),
                                              )
                                            : Container(),
                                      ),
                                      spaceW(10),
                                      Text(
                                        "${snapshot.data[index]['name']}",
                                        style: headingStyle.copyWith(
                                            color: (DataBaseCubit.get(context)
                                                            .isselected[
                                                        "${snapshot.data[index]['id']}"] ==
                                                    true)
                                                ? HexColor("#3080D1")
                                                : HexColor("#323232"),
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }));
                  } else {
                    return InkWell(
                      onTap: () {
                        if (DataBaseCubit.get(context).isselected[sectionId] ==
                            true) {
                          DataBaseCubit.get(context)
                              .deletaFromDB(sectionID: sectionId);
                        } else {
                          DataBaseCubit.get(context).inserttoDatabase(
                              sectionTitle: sectiontitle, sectionID: sectionId);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: (DataBaseCubit.get(context)
                                        .isselected[sectionId] ==
                                    true)
                                ? HexColor("#3080D1").withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: (DataBaseCubit.get(context)
                                          .isselected[sectionId] ==
                                      true)
                                  ? HexColor("#3080D1")
                                  : HexColor("#323232"),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: (DataBaseCubit.get(context)
                                                .isselected[sectionId] ==
                                            true)
                                        ? HexColor("#3080D1")
                                        : HexColor("#323232"),
                                  )),
                              child: (DataBaseCubit.get(context)
                                          .isselected[sectionId] ==
                                      true)
                                  ? Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: HexColor("#3080D1")),
                                    )
                                  : Container(),
                            ),
                            spaceW(10),
                            Text(
                              sectiontitle,
                              style: headingStyle.copyWith(
                                  color: (DataBaseCubit.get(context)
                                              .isselected[sectionId] ==
                                          true)
                                      ? HexColor("#3080D1")
                                      : HexColor("#323232"),
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              });
        },
        listener: (context, state) {});
  }
}

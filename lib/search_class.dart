import 'package:elmanhag_app/more/componnent/listcard.dart';
import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'controller/searchData.dart';

class LessonpapersSearch extends SearchDelegate {
  LessonpapersSearch()
      : super(
            searchFieldLabel: 'البحث',
            searchFieldStyle: headingStyle.copyWith(
              color: Colors.grey,
              fontSize: 18,
            ));
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: getSearchdata(txt: query.toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: LessonCardlist(
                          title: "${snapshot.data[i]["title"]}",
                          image: "",
                          itemId: "${snapshot.data[i]["id"]}",
                          itemDesc: ""),
                    );
                  },
                );
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: getSearchdata(txt: query.toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: LessonCardlist(
                          title: "${snapshot.data[i]["title"]}",
                          image: "",
                          itemId: "${snapshot.data[i]["id"]}",
                          itemDesc: ""),
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => DetailScreen(
                      //                 itemId: "${snapshot.data[i]["id"]}",
                      //               )));
                      // },
                    );
                  },
                );
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            });
  }
}

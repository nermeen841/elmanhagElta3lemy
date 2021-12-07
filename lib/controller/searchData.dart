import 'dart:convert';

import 'package:elmanhag_app/httpServices/endpoints.dart';
import 'package:http/http.dart' as http;

getSearchdata({required String txt}) async {
  try {
    var response = await http
        .get(Uri.parse(EndPoints.SEARCH + "?search=$txt&per_page=100&page=1"));
    var jsonData = json.decode(response.body);
    // for (var item in jsonData) {
    //   var data =
    //       await http.get(Uri.parse(EndPoints.DETAILSDATA + "/${item['id']}"));

    //   var jsondata = json.decode(data.body);
    //   image = jsondata['x_featured_media_medium'];
    // }
    return jsonData;
  } catch (error) {
    print("error while get search data ------------ : ${error.toString()}");
  }
}

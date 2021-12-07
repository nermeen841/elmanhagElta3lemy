import 'dart:convert';

import 'package:elmanhag_app/httpServices/endpoints.dart';
import 'package:http/http.dart' as http;

getClasses() async {
  try {
    var response = await http.get(Uri.parse(EndPoints.CATEGORIES +
        "?parent=913&per_page=100&orderby=id&order=asc"));

    var jsonData = json.decode(response.body);

    return jsonData;
  } catch (error) {
    print(
        "error while get classes data ------------------- ${error.toString()}");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////

getgrades({required String sectionId}) async {
  var jsonData;
  try {
    var response = await http.get(Uri.parse(EndPoints.CATEGORIES +
        "?parent=$sectionId&per_page=100&orderby=id&order=asc"));
    jsonData = json.decode(response.body);

    return jsonData;
  } catch (error) {
    print(
        "grades error data ----------------------------- ${error.toString()}");
  }
}

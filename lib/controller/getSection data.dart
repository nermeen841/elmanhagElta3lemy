import 'dart:convert';

import 'package:elmanhag_app/httpServices/endpoints.dart';
import 'package:http/http.dart' as http;

getSectionListdata({required String sectionId}) async {
  try {
    var response = await http.get(Uri.parse(
        EndPoints.SECTIONLISTDATA + "?per_page=10&categories=$sectionId"));
    var jsonData = json.decode(response.body);
    return jsonData;
  } catch (error) {
    print(
        "error while get section data --------------------------------- : ${error.toString()}");
  }
}

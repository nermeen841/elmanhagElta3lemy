import 'dart:convert';

import 'package:elmanhag_app/httpServices/endpoints.dart';
import 'package:http/http.dart' as http;

getdetailData({required String id}) async {
  try {
    var response = await http.get(Uri.parse(EndPoints.DETAILSDATA + "/$id"));
    var data = json.decode(response.body);
    return data;
  } catch (error) {
    print("error while get detail data -------------- : ${error.toString()}");
  }
}

import 'dart:convert';

import 'package:elmanhag_app/httpServices/endpoints.dart';
import 'package:http/http.dart' as http;

getHomeAds() async {
  try {
    var response = await http.get(Uri.parse(EndPoints.HOMEADS));

    var jsonData = json.decode(response.body);
    return jsonData;
  } catch (error) {
    print("error while get home ads : ${error.toString()}");
  }
}

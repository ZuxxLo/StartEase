import 'dart:convert';

import 'package:http/http.dart' as http;

import '../main.dart';

class Crud {
  static getRequest(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("response error ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("catch error $e");
      return null;
    }
  }

  static postRequest(String url, Map data) async {
    try {
      http.Response response = await http.post(Uri.parse(url), body: data);
 
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
         MainFunctions.somethingWentWrongSnackBar("${response.statusCode}");

        return null;
      }
    } catch (e) {
       MainFunctions.somethingWentWrongSnackBar("$e");

      return null;
    }
  }
}

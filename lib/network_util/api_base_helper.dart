import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app_exception.dart';
class ApiBaseHelper {

  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      print('url: ${url}');
      final response = await http.get(url);
      print("response in main:${response.statusCode}");
      responseJson = _returnResponse(response);
    } catch(exception) {
      print('error in main:${exception.toString()}');
      throw FetchDataException('Error while Communicating with server please try again...');
    }
    return responseJson;
  }


  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print("response after decoding: $responseJson");
        return responseJson;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}

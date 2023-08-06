import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_clone/api/exceptions/excpetions_hanlder.dart';

class ApiService {
  Future<Map<String, dynamic>> get({required String url, required Map<String, String> queryParameters}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var uri = Uri.parse(url).replace(
      queryParameters: queryParameters,
    );

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }
}

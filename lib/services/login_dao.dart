import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/login.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:http/http.dart' as http;

class LoginDao {
  Future<Login> login(
    String phone,
    String senha,
  ) async {
    final response = await http.post(
      Uri.parse('$serverURL/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "tell": phone,
        "senha": senha,
      }),
    );

    if (response.statusCode == 200) {
      // print('response.body');
      // print(response.body);
      return Login.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}

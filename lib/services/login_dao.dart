import 'dart:convert';

import 'package:fennec_desktop/models/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginDao {
  Future<Login> login(
    String phone,
    String senha,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
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
      return Login.fromJson(jsonDecode(response.body));
    } else {
      print('error');
      print(response.body);
      throw ErrorDescription(response.body);
    }
  }
}

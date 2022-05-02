import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/main_feed_content.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainFeedDao {
  Future<MainFeed> getFeedContent(int index) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.get(
      Uri.parse('$serverURL/feed/pagination/${index.toString()}/5'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      // print('mandando resposta');
      // print(response.body);

      return MainFeed.fromJson(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
    } else {
      // print('response.erro');
      // print(response.body);
      throw ErrorMessage.fromJson(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
    }
  }

  Future<PostContent> postContent(
    String post,
    // String tipo,
    // String status,
  ) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/feed/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(<String, dynamic>{
        "texto": post,
        "tipo": "texto",
        "status": "status",
      }),
    );

    if (response.statusCode == 200) {
      // print('response.body');
      // print(response.body);
      return PostContent.fromJson(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
    } else {
      print('error');
      print(response.body);
      throw ErrorDescription(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
    }
  }
}

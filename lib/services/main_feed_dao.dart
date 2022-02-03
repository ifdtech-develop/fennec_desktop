import 'dart:convert';

import 'package:fennec_desktop/models/main_feed_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainFeedDao {
  Future<MainFeed> getFeedContent() async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/feed/pagination/0/5'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5Mjk5NTM1OTg1MiIsImV4cCI6MTY0NDcxMTI0OX0.Ya3syIrfNDAusPgHTJPMi03pDKYFZfjdo55jr3MgWifEiZ4Irp8oyRjciKc2kRfhYRnYzKvu3H6-_xh-Rwm_dA',
    });

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
      throw Exception('Failed to load squad feed');
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
      Uri.parse('http://localhost:3000/feed/send/0'),
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
      return PostContent.fromJson(jsonDecode(response.body));
    } else {
      print('error');
      print(response.body);
      throw ErrorDescription(response.body);
    }
  }
}

import 'dart:convert';

import 'package:fennec_desktop/models/team_feed.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TeamFeedDao {
  Future<TeamFeed> getFeedContent(int index, int idTeam) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.get(
        Uri.parse(
          '$serverURL/feed/pagbytime/${index.toString()}/5/${idTeam.toString()}',
        ),
        headers: {'Authorization': token});

    if (response.statusCode == 200) {
      // print('mandando resposta');
      // print(response.body);

      return TeamFeed.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      // print('response.erro');
      // print(response.body);
      throw Exception('Failed to load team feed');
    }
  }

  Future<PostContent> postContent(
    String post,
    int teamId,
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
      Uri.parse('$serverURL/feed/send/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(<String, dynamic>{
        "texto": post,
        "tipo": "texto",
        "status": "status",
        "time": {"id": teamId}
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

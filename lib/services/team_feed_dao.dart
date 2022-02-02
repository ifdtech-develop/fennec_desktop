import 'dart:convert';

import 'package:fennec_desktop/models/team_feed.dart';
import 'package:http/http.dart' as http;

class TeamFeedDao {
  Future<TeamFeed> getFeedContent() async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/feed/pagbytime/0/5/1'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5Mjk5MTIzNDU1NiIsImV4cCI6MTY0NDYzMjMxM30.R5HU2G102MRpwi3LFLZU6ep-nTJeeER8mldzyt8oSerez2ZGHvDxj9h0gcUmwJQtitTcu4-NUFz4tFAx570SfQ',
    });

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
}

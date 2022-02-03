import 'dart:convert';

import 'package:fennec_desktop/models/squad_feed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SquadFeedDao {
  Future<SquadFeed> getFeedContent() async {
    final response = await http.get(
        Uri.parse('http://localhost:3000/feed/pagbysquad/0/5/1'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5Mjk5MTIzNDU1NiIsImV4cCI6MTY0NDYzMjMxM30.R5HU2G102MRpwi3LFLZU6ep-nTJeeER8mldzyt8oSerez2ZGHvDxj9h0gcUmwJQtitTcu4-NUFz4tFAx570SfQ',
        });

    if (response.statusCode == 200) {
      // print('mandando resposta');
      // print(response.body);

      return SquadFeed.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    final response = await http.post(
      Uri.parse('http://localhost:3000/feed/send/2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5Mjk5NTM1OTg1MiIsImV4cCI6MTY0NDcxMTI0OX0.Ya3syIrfNDAusPgHTJPMi03pDKYFZfjdo55jr3MgWifEiZ4Irp8oyRjciKc2kRfhYRnYzKvu3H6-_xh-Rwm_dA',
      },
      body: jsonEncode(<String, dynamic>{
        "texto": post,
        "tipo": "texto",
        "status": "status",
        "squad": {"id": 1}
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

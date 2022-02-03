import 'dart:convert';

import 'package:fennec_desktop/models/main_feed_content.dart';
import 'package:http/http.dart' as http;

class MainFeedDao {
  Future<MainFeedContent> getFeedContent() async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/feed/pagination/0/5'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5Mjk5NTM1OTg1MiIsImV4cCI6MTY0NDcxMTI0OX0.Ya3syIrfNDAusPgHTJPMi03pDKYFZfjdo55jr3MgWifEiZ4Irp8oyRjciKc2kRfhYRnYzKvu3H6-_xh-Rwm_dA',
    });

    if (response.statusCode == 200) {
      print('mandando resposta');
      print(response.body);

      return MainFeedContent.fromJson(
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
}

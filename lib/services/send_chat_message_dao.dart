import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/send_chat_message.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SendChatMessageDao {
  Future<SendChatMessage> sendChatMessage(
      String receiverId, String message) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/chat/$receiverId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: jsonEncode(<String, dynamic>{
        "content": message,
      }),
    );

    if (response.statusCode == 200) {
      // print('success');
      // print(response.body);
      return SendChatMessage.fromJson(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}

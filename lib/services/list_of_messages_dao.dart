import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/list_of_messages.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListOfMessagesDao {
  Future<List<ListOfMessages>> getListOfMessages(
      String senderId, String receiverId, int page) async {
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
          '$serverURL/messages/$senderId/$receiverId?page=$page&size=$qtdMessages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );

    if (response.statusCode == 200) {
      List<ListOfMessages> listOfMessagesFromJson(String str) =>
          List<ListOfMessages>.from(
            json.decode(str).map(
                  (x) => ListOfMessages.fromJson(x),
                ),
          );

      return listOfMessagesFromJson(utf8.decode(response.bodyBytes));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}

import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetUsersDao {
  Future<List<ListOfUsers>> getUsers() async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.get(
      Uri.parse('$serverURL/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );

    if (response.statusCode == 200) {
      List<ListOfUsers> listUsersFromJson(String str) => List<ListOfUsers>.from(
            json.decode(str).map(
                  (x) => ListOfUsers.fromJson(x),
                ),
          );

      return listUsersFromJson(utf8.decode(response.bodyBytes));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}

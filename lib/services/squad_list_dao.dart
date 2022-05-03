import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
import 'package:fennec_desktop/models/squad_list.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:fennec_desktop/utils/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SquadListDao {
  Future<List<SquadList>> listaSquad() async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/time/listasquads'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {"id": teamId},
      ),
    );

    if (response.statusCode == 200) {
      List<SquadList> listaSquadFromJson(String str) => List<SquadList>.from(
            json.decode(str).map(
                  (x) => SquadList.fromJson(x),
                ),
          );

      return listaSquadFromJson(
        utf8.decode(response.bodyBytes),
      );
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(response.body));
    }
  }

  Future<SquadList> createSquad(
      String description, String name, int teamId) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/squad'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "description": description,
        "name": name,
        "time": {"id": teamId}
      }),
    );

    if (response.statusCode == 200) {
      return SquadList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(response.body));
    }
  }

  Future<List<ListOfUsers>> usersOnSquadList(teamId) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/squad/listausuarios'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": teamId,
      }),
    );

    if (response.statusCode == 200) {
      List<ListOfUsers> listFromJson(String str) => List<ListOfUsers>.from(
            json.decode(str).map(
                  (x) => ListOfUsers.fromJson(x),
                ),
          );

      return listFromJson(utf8.decode(response.bodyBytes));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(response.body));
    }
  }

  Future<List<ListOfUsers>> addUsersToSquad(int squadId, usersJson) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/squad/addusuario'),
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": squadId,
        "users": usersJson,
      }),
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

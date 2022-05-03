import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
import 'package:fennec_desktop/models/squad_list.dart';
import 'package:fennec_desktop/models/team_list.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TeamListDao {
  Future<List<TeamList>> listaTime() async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.get(
      Uri.parse('$serverURL/time/lista'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      List<TeamList> listaTimeFromJson(String str) => List<TeamList>.from(
            json.decode(str).map(
                  (x) => TeamList.fromJson(x),
                ),
          );

      return listaTimeFromJson(utf8.decode(response.bodyBytes));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  Future<List<ListOfUsers>> usersOnTeamList(int id) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/time/listausuarios'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      List<ListOfUsers> listFromJson(String str) => List<ListOfUsers>.from(
            json.decode(str).map(
                  (x) => ListOfUsers.fromJson(x),
                ),
          );

      return listFromJson(response.body);
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(response.body));
    }
  }

  Future<List<SquadList>> teamSquads(int idTeam) async {
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
        {"id": idTeam},
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

  Future<TeamList> createTeam(String name, String description) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/time'),
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "description": description,
        "name": name,
      }),
    );

    if (response.statusCode == 200) {
      return TeamList.fromJson(jsonDecode(response.body));
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(response.body));
    }
  }

  Future<List<ListOfUsers>> addUsersToTeam(int teamId, usersJson) async {
    final String token;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/time/addusuario'),
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": teamId,
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

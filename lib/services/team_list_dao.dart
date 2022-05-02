import 'dart:convert';

import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
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

      return listaTimeFromJson(response.body);
    } else {
      print('error');
      print(response.body);
      throw ErrorMessage.fromJson(jsonDecode(response.body));
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
}

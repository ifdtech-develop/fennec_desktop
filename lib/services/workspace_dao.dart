import 'dart:convert';

import 'package:fennec_desktop/models/backoffice_transactions.dart';
import 'package:http/http.dart' as http;

import '../models/backoffice_transactions.dart';

class WorkspaceDAO {
<<<<<<< HEAD
   Future getAllTransactions() async {
     final response = await http.get(
      Uri.parse('https://3etf8ezp82.execute-api.sa-east-1.amazonaws.com/prod/allTransactions'));
      print("print");
      print(response);
      if (response.statusCode == 200) {
    return BackofficeTransactions.fromJson(json.decode(response.body));
  } else {
    throw Exception('Falha ao carregar');
  }
   }
}
=======
  Future<List> getAllTransactions() async {
    final response = await http.get(Uri.parse(
        'https://3etf8ezp82.execute-api.sa-east-1.amazonaws.com/prod/allTransactions'));
    print("print");
    if (response.statusCode == 200) {
      var list =
          (((jsonDecode(utf8.decode(response.bodyBytes))) as List).toList());
      // print(list);
      // var formated =list.map((dynamic json)=> BackofficeTransactions.fromJson(json)).toList();
      // print(formated);
>>>>>>> 7c78a0c (Backoffice getting data from backend)


      return list;

    } else {
      throw Exception('Failed to load post');
    }
  }
}
class WorkspaceTotalDAO {
  // Future to get a simple json object from a url

  // ignore: non_constant_identifier_names
  Future<Map<String, dynamic>> TotalTransactions() async {
    final response = await http.get(Uri.parse(
        'https://3etf8ezp82.execute-api.sa-east-1.amazonaws.com/prod/TotalTransactions'));
    print("print");
    if (response.statusCode == 200) {
      // var list =
      //     (jsonDecode(response.body) as Map<String, dynamic>);
      // print(list);
      // var formated =list.map((dynamic json)=> BackofficeTransactions.fromJson(json)).toList();
      // print(formated);


      return (jsonDecode(utf8.decode(response.bodyBytes))) as  Map<String, dynamic>;

    } else {
      throw Exception('Failed to load post');
    }
  }
}

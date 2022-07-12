import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/backoffice_transactions.dart';

class WorkspaceDAO {
   Future<List<BackofficeTransactions>> getAllTransactions() async {
     final response = await http.get(
      Uri.parse('https://3etf8ezp82.execute-api.sa-east-1.amazonaws.com/prod/allTransactions'));
      print("print");
      print(response);
      if (response.statusCode == 200) {
        // print(BackofficeTransactions.fromJson(json.decode(response.body)));
    // return BackofficeTransactions.fromJson(json.decode(response.body));
    return (json.decode(response.body) as List)
        .map((i) => BackofficeTransactions.fromJson(i))
        .toList();
      } else {
        throw Exception('Failed to load post');
      }
    }
  // } else {
  //   throw Exception('Falha ao carregar');
  // }
  //  }
}


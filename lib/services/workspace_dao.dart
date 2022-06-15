import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/backoffice_transactions.dart';

class WorkspaceDAO {
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


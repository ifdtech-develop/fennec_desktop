import 'dart:ffi';

import 'package:intl/intl.dart';

class BackofficeTransactions {
  final int? id;
  final String? digitable;
  final String? backofficeTransactionsBarCode;
  final int? type;
  final double? originalValue;
  final double? value;
  final double? valueWithAdditional;
  final double? valueWithDiscount;
  final int? transactionidauthorize;
  final int? authentication;
  final String? convenant;
  final String? paynetId;
  final DateFormat? createDate;
  final bool? isExpired;
  final int? transactionid;
  final String? nome;
  final String? email;
  final String? cpf;
  final String? paynetauthorizationCode;
  final String? valorBoleto;
  final String? valorCartao;
  final String? valorTaxa;
  final double? unformatedCard;
  final String? unformatedTaxa;
  final String? barCode;
  final String? cardFlag;
  final String? lastDigits;
  final String? installments;
  final String? tipo;
  final String? autenticacao;
  final String? status;

  BackofficeTransactions({
    this.id,
    this.digitable,
    this.backofficeTransactionsBarCode,
    this.type,
    this.originalValue,
    this.value,
    this.valueWithAdditional,
    this.valueWithDiscount,
    this.transactionidauthorize,
    this.authentication,
    this.convenant,
    this.paynetId,
    this.createDate,
    this.isExpired,
    this.transactionid,
    this.nome,
    this.email,
    this.cpf,
    this.paynetauthorizationCode,
    this.valorBoleto,
    this.valorCartao,
    this.valorTaxa,
    this.unformatedCard,
    this.unformatedTaxa,
    this.barCode,
    this.cardFlag,
    this.lastDigits,
    this.installments,
    this.tipo,
    this.autenticacao,
    this.status,
  });

// make a factory from the JSON map
  factory BackofficeTransactions.fromJson(Map<String, dynamic> json) {
    return BackofficeTransactions(
      id: json["id"],
      digitable: json["digitable"],
      backofficeTransactionsBarCode: json["backofficeTransactionsBarCode"],
      type: json["type"],
      originalValue: json["originalValue"],
      value: json["value"].toDouble(),
      valueWithAdditional: json["valueWithAdditional"],
      valueWithDiscount: json["valueWithDiscount"],
      transactionidauthorize: json["transactionidauthorize"],
      authentication: json["authentication"],
      convenant: json["convenant"],
      paynetId: json["paynetId"],
      createDate: json["createDate"]
          .DateFormat('dd/MM/yyyy')
          .format(DateFormat('yyyy-MM-dd'))
          .parse(json["createDate"]),
      isExpired: json["isExpired"],
      transactionid: json["transactionid"],
      nome: json["nome"],
      email: json["email"],
      cpf: json["cpf"],
      paynetauthorizationCode: json["paynetauthorizationCode"].toString(),
      valorBoleto: json["valorBoleto"],
      valorCartao: json["valorCartao"],
      valorTaxa: json["valorTaxa"],
      unformatedCard: json["unformatedCard"].toDouble(),
      unformatedTaxa: json["unformatedTaxa"].toDouble(),
      barCode: json["barCode"],
      cardFlag: json["cardFlag"],
      lastDigits: json["lastDigits"],
      installments: json["installments"],
      tipo: json["tipo"],
      autenticacao: json["autenticacao"],
      status: json["status"],
    );
  }

  // make a JSON map from the object
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "digitable": digitable,
      "backofficeTransactionsBarCode": backofficeTransactionsBarCode,
      "type": type,
      "originalValue": originalValue,
      "value": value,
      "valueWithAdditional": valueWithAdditional,
      "valueWithDiscount": valueWithDiscount,
      "transactionidauthorize": transactionidauthorize,
      "authentication": authentication,
      "convenant": convenant,
      "paynetId": paynetId,
      "createDate": createDate,
      "isExpired": isExpired,
      "transactionid": transactionid,
      "nome": nome,
      "email": email,
      "cpf": cpf,
      "paynetauthorizationCode": paynetauthorizationCode,
      "valorBoleto": valorBoleto,
      "valorCartao": valorCartao,
      "valorTaxa": valorTaxa,
      "unformatedCard": unformatedCard,
      "unformatedTaxa": unformatedTaxa,
      "barCode": barCode,
      "cardFlag": cardFlag,
      "lastDigits": lastDigits,
      "installments": installments,
      "tipo": tipo,
      "autenticacao": autenticacao,
      "status": status,
    };
  }

  // make a factory from the JSON map
}
class TotalTransactions {
    TotalTransactions({
        required this.totalBoleto,
        required this.totalCartao,
    });

    final String? totalBoleto;
    final String? totalCartao;

      // make a JSON map from the object
      Map<String, dynamic> toJson() {
        return {
            "totalBoleto": totalBoleto,
            "totalCartao": totalCartao,
        };
      }
      // make a factory from the JSON map
      factory TotalTransactions.fromJson(Map<String, dynamic> json) {
        return TotalTransactions(
            totalBoleto: json["totalBoleto"],
            totalCartao: json["totalCartao"],
        );
      }
}
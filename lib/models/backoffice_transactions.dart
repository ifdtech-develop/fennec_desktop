// class BackofficeTransactions {
//   final String nome;
//   final String barCode;
//   final String valorBoleto;
//   final String valorCartao;
//   final String valorTaxa;
//   final String tipo;
//   final String autenticacao;
//   final String status;

//   BackofficeTransactions({
//     required this.nome,
//     required this.barCode,
//     required this.valorBoleto,
//     required this.valorCartao,
//     required this.valorTaxa,
//     required this.tipo,
//     required this.autenticacao,
//     required this.status,
//   });

//   factory BackofficeTransactions.fromJson(Map<String, dynamic> json) {
//     return BackofficeTransactions(
//       nome: json["nome"],
//       barCode: json["barCode"],
//       valorBoleto: json["valorBoleto"],
//       valorCartao: json["valorCartao"],
//       valorTaxa: json["valorTaxa"],
//       tipo: json["tipo"],
//       autenticacao: json["autenticacao"],
//       status: json["status"],
//     );
//   }
// }

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
  final String? createDate;
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
      value: json["value"],
      valueWithAdditional: json["valueWithAdditional"],
      valueWithDiscount: json["valueWithDiscount"],
      transactionidauthorize: json["transactionidauthorize"],
      authentication: json["authentication"],
      convenant: json["convenant"],
      paynetId: json["paynetId"],
      createDate: json["createDate"],
      isExpired: json["isExpired"],
      transactionid: json["transactionid"],
      nome: json["nome"],
      email: json["email"],
      cpf: json["cpf"],
      paynetauthorizationCode: json["paynetauthorizationCode"],
      valorBoleto: json["valorBoleto"],
      valorCartao: json["valorCartao"],
      valorTaxa: json["valorTaxa"],
      unformatedCard: json["unformatedCard"],
      unformatedTaxa: json["unformatedTaxa"],
      barCode: json["barCode"],
      cardFlag: json["cardFlag"],
      lastDigits: json["lastDigits"],
      installments: json["installments"],
      tipo: json["tipo"],
      autenticacao: json["autenticacao"],
      status: json["status"],
    );
  }
}

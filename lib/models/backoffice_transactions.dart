class BackofficeTransactions {
  final String nome;
  final String barCode;
  final String valorBoleto;
  final String valorCartao;
  final String valorTaxa;
  final String tipo;
  final String autenticacao;
  final String status;
  
  BackofficeTransactions({
    required this.nome,
    required this.barCode,
    required this.valorBoleto,
    required this.valorCartao,
    required this.valorTaxa,
    required this.tipo,
    required this.autenticacao,
    required this.status,
  });

  factory BackofficeTransactions.fromJson(Map<String, dynamic> json) {
    return BackofficeTransactions(
      nome: json["nome"],
      barCode: json["barCode"],
      valorBoleto: json["valorBoleto"],
      valorCartao: json["valorCartao"],
      valorTaxa: json["valorTaxa"],
      tipo: json["tipo"],
      autenticacao: json["autenticacao"],
      status: json["status"],
    );
  }
}

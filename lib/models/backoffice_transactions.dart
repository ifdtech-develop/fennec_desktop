class BackofficeTransactions {
  final String typeTransaction;
  final String clientName;
  final int barCode;
  final int cardNumber;
  final double valueTransaction;
  final String status;

  BackofficeTransactions({
    required this.typeTransaction,
    required this.clientName,
    required this.barCode,
    required this.cardNumber,
    required this.valueTransaction,
    required this.status,
  });

  factory BackofficeTransactions.fromJson(Map<String, dynamic> json) {
    return BackofficeTransactions(
      barCode: json["barCode"],
      valueTransaction: json["valueTransaction"],
      status: json["status"],
      clientName: json["clientName"],
      cardNumber: json["cardNumber"],
      typeTransaction: json["typeTransaction"],
    );
  }
}

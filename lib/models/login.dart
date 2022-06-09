class Login {
  final String token;
  final String tell;
  final String email;
  final String nome;
  final String id;

  Login({
    required this.token,
    required this.tell,
    required this.email,
    required this.nome,
    required this.id,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['Token'],
      tell: json['tell'],
      email: json['email'],
      nome: json['nome'],
      id: json['id'],
    );
  }
}

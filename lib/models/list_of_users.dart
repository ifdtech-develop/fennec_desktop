class ListOfUsers {
  int? id;
  String? name;
  String? rg;
  String? birthDay;
  String? tell;
  String? email;
  String? hierarquia;
  double? averageRating;
  String? urlLatter;
  String? urlLinkedin;
  List<String>? perfis;
  String? nivel;

  ListOfUsers({
    this.id,
    this.name,
    this.rg,
    this.birthDay,
    this.tell,
    this.email,
    this.hierarquia,
    this.averageRating,
    this.urlLatter,
    this.urlLinkedin,
    this.perfis,
    this.nivel,
  });

  ListOfUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rg = json['rg'];
    birthDay = json['birthDay'];
    tell = json['tell'];
    email = json['email'];
    hierarquia = json['hierarquia'];
    averageRating = json['averageRating'];
    urlLatter = json['urlLatter'];
    urlLinkedin = json['urlLinkedin'];
    perfis = json['perfis'].cast<String>();
    nivel = json['nivel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rg'] = rg;
    data['birthDay'] = birthDay;
    data['tell'] = tell;
    data['email'] = email;
    data['hierarquia'] = hierarquia;
    data['averageRating'] = averageRating;
    data['urlLatter'] = urlLatter;
    data['urlLinkedin'] = urlLinkedin;
    data['perfis'] = perfis;
    data['nivel'] = nivel;
    return data;
  }
}

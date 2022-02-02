class TeamFeed {
  final List<PostContent> content;

  TeamFeed({required this.content});

  factory TeamFeed.fromJson(Map<String, dynamic> json) {
    List<PostContent> listaPosts = [];

    for (dynamic i in json['content']) {
      PostContent post = PostContent.fromJson(i);
      listaPosts.add(post);
    }

    return TeamFeed(
      content: listaPosts,
    );
  }
}

class PostContent {
  final int idMensagem;
  final String hora;
  final String data;
  final String texto;
  final String tipo;
  final String meio;
  final Time time;
  final String? squad;
  final String status;
  final UsuarioId usuarioId;

  PostContent({
    required this.idMensagem,
    required this.hora,
    required this.data,
    required this.texto,
    required this.tipo,
    required this.meio,
    required this.time,
    this.squad,
    required this.status,
    required this.usuarioId,
  });

  factory PostContent.fromJson(Map<String, dynamic> json) {
    return PostContent(
      idMensagem: json['idMensagem'],
      hora: json['hora'],
      data: json['data'],
      texto: json['texto'],
      tipo: json['tipo'],
      meio: json['meio'],
      time: Time.fromJson(json['time']),
      squad: json['squad'],
      status: json['status'],
      usuarioId: UsuarioId.fromJson(json['usuarioId']),
    );
  }
}

class Time {
  final int id;
  final String name;
  final String description;

  Time({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class UsuarioId {
  final int id;
  final String name;
  final String hierarquia;
  final String nivel;

  UsuarioId({
    required this.id,
    required this.name,
    required this.hierarquia,
    required this.nivel,
  });

  factory UsuarioId.fromJson(Map<String, dynamic> json) {
    return UsuarioId(
      id: json['id'],
      name: json['name'],
      hierarquia: json['hierarquia'],
      nivel: json['nivel'],
    );
  }
}

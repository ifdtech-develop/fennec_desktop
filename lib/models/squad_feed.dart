class SquadFeed {
  final List<PostContent> content;

  SquadFeed({required this.content});

  factory SquadFeed.fromJson(Map<String, dynamic> json) {
    List<PostContent> listaPosts = [];

    for (dynamic i in json['content']) {
      PostContent post = PostContent.fromJson(i);
      listaPosts.add(post);
    }

    return SquadFeed(
      content: listaPosts,
    );
  }
}

class PostContent {
  final int? idMensagem;
  final String? hora;
  final String? data;
  final String? texto;
  final String? tipo;
  final String? meio;
  final Time? time;
  final Squad? squad;
  final String? status;
  final UsuarioId? usuarioId;

  PostContent({
    this.idMensagem,
    this.hora,
    this.data,
    this.texto,
    this.tipo,
    this.meio,
    this.time,
    this.squad,
    this.status,
    this.usuarioId,
  });

  factory PostContent.fromJson(Map<String, dynamic> json) {
    return PostContent(
      idMensagem: json['idMensagem'],
      hora: json['hora'],
      data: json['data'],
      texto: json['texto'],
      tipo: json['tipo'],
      meio: json['meio'],
      time: json['time'],
      squad: Squad.fromJson(json['squad']),
      status: json['status'],
      usuarioId: UsuarioId.fromJson(json['usuarioId']),
    );
  }
}

class Time {
  final int? id;
  final String? name;
  final String? description;
  final UsuarioId? leadId;

  Time({
    this.id,
    this.name,
    this.description,
    this.leadId,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      leadId: UsuarioId.fromJson(json['leadId']),
    );
  }
}

class Squad {
  final int? id;
  final String? name;
  final String? description;
  final Time? time;

  Squad({
    this.id,
    this.name,
    this.description,
    this.time,
  });

  factory Squad.fromJson(Map<String, dynamic> json) {
    return Squad(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      time: Time.fromJson(json['time']),
    );
  }
}

class UsuarioId {
  final int? id;
  final String? name;
  final String? hierarquia;
  final String? nivel;

  UsuarioId({
    this.id,
    this.name,
    this.hierarquia,
    this.nivel,
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

class SquadList {
  int? id;
  String? name;
  String? description;
  double? averageRating;
  dynamic creationDate;
  LeadId? leadId;
  dynamic status;
  Time? time;
  dynamic vacancies;

  SquadList({
    this.id,
    this.name,
    this.description,
    this.averageRating,
    this.creationDate,
    this.leadId,
    this.status,
    this.time,
    this.vacancies,
  });

  SquadList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    averageRating = json['averageRating'];
    creationDate = json['creationDate'];
    leadId = json['leadId'] != null ? LeadId.fromJson(json['leadId']) : null;
    status = json['status'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    vacancies = json['vacancies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['averageRating'] = averageRating;
    data['creationDate'] = creationDate;
    if (leadId != null) {
      data['leadId'] = leadId!.toJson();
    }
    data['status'] = status;
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['vacancies'] = vacancies;
    return data;
  }
}

class LeadId {
  int? id;
  String? name;
  String? hierarquia;
  String? nivel;

  LeadId({this.id, this.name, this.hierarquia, this.nivel});

  LeadId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hierarquia = json['hierarquia'];
    nivel = json['nivel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hierarquia'] = hierarquia;
    data['nivel'] = nivel;
    return data;
  }
}

class Time {
  int? id;
  String? name;
  String? description;
  LeadId? leadId;

  Time({this.id, this.name, this.description, this.leadId});

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    leadId = json['leadId'] != null ? LeadId.fromJson(json['leadId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    if (leadId != null) {
      data['leadId'] = leadId!.toJson();
    }
    return data;
  }
}

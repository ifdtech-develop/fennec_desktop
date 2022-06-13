class ListOfMessages {
  int? id;
  String? chatId;
  dynamic timestamp;
  SenderId? senderId;
  SenderId? recipientId;
  String? status;
  String? content;

  ListOfMessages({
    this.id,
    this.chatId,
    this.timestamp,
    this.senderId,
    this.recipientId,
    this.status,
    this.content,
  });

  ListOfMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chatId'];
    timestamp = json['timestamp'];
    senderId =
        json['senderId'] != null ? SenderId.fromJson(json['senderId']) : null;
    recipientId = json['recipientId'] != null
        ? SenderId.fromJson(json['recipientId'])
        : null;
    status = json['status'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chatId'] = chatId;
    data['timestamp'] = timestamp;
    if (senderId != null) {
      data['senderId'] = senderId!.toJson();
    }
    if (recipientId != null) {
      data['recipientId'] = recipientId!.toJson();
    }
    data['status'] = status;
    data['content'] = content;
    return data;
  }
}

class SenderId {
  int? id;
  String? name;

  SenderId({this.id, this.name});

  SenderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

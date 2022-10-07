class SendMessageModel {
  int? statusCode;
  String? status;
  SendMessageData? data;
  String? message;

  SendMessageModel({this.statusCode, this.status, this.data, this.message});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    data = json['data'] != null ? new SendMessageData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class SendMessageData {
  String? senderId;
  String? receiverId;
  int? conversationId;
  String? message;
  String? attachment;
  String? updatedAt;
  String? createdAt;
  int? id;

  SendMessageData(
      {this.senderId,
        this.receiverId,
        this.conversationId,
        this.message,
        this.attachment,
        this.updatedAt,
        this.createdAt,
        this.id});

  SendMessageData.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    conversationId = json['conversation_id'];
    message = json['message'];
    attachment = json['attachment'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['conversation_id'] = this.conversationId;
    data['message'] = this.message;
    data['attachment'] = this.attachment;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
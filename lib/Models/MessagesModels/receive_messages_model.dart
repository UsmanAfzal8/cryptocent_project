// class ReceiveMessageModel {
//   int? statusCode;
//   String? status;
//   List<ReceiveMessagesData>? data;
//   String? message;
//
//   ReceiveMessageModel({this.statusCode, this.status, this.data, this.message});
//
//   ReceiveMessageModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <ReceiveMessagesData>[];
//       json['data'].forEach((v) {
//         data!.add(new ReceiveMessagesData.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class ReceiveMessagesData {
//   int? id;
//   String? senderId;
//   String? receiverId;
//   String? conversationId;
//   var messageParentId;
//   String? message;
//   String? attachment;
//   String? seenStatus;
//   String? createdAt;
//   String? updatedAt;
//
//   ReceiveMessagesData(
//       {this.id,
//         this.senderId,
//         this.receiverId,
//         this.conversationId,
//         this.messageParentId,
//         this.message,
//         this.attachment,
//         this.seenStatus,
//         this.createdAt,
//         this.updatedAt});
//
//   ReceiveMessagesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     senderId = json['sender_id'];
//     receiverId = json['receiver_id'];
//     conversationId = json['conversation_id'];
//     messageParentId = json['message_parent_id'];
//     message = json['message'];
//     attachment = json['attachment'];
//     seenStatus = json['seen_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['sender_id'] = this.senderId;
//     data['receiver_id'] = this.receiverId;
//     data['conversation_id'] = this.conversationId;
//     data['message_parent_id'] = this.messageParentId;
//     data['message'] = this.message;
//     data['attachment'] = this.attachment;
//     data['seen_status'] = this.seenStatus;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
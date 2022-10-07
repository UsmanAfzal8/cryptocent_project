// // To parse this JSON data, do
// //
// //     final notificationModel = notificationModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));
//
// String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());
//
// class NotificationModel {
//   NotificationModel({
//     this.statusCode,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   int? statusCode;
//   String? status;
//   String? message;
//   List<Datum>? data;
//
//   factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
//     statusCode: json["statusCode"],
//     status: json["status"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.title,
//     this.description,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int? id;
//   String? title;
//   String? description;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     image: json["image"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "image": image,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//   };
// }

class NotificationData {
  int? id;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  NotificationData(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
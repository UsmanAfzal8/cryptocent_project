// class UpdatePasswordModel {
//   String? status;
//   String? message;
//
//   UpdatePasswordModel({this.status, this.message});
//
//   UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final updatePasswordModel = updatePasswordModelFromJson(jsonString);

import 'dart:convert';

UpdatePasswordModel updatePasswordModelFromJson(String str) => UpdatePasswordModel.fromJson(json.decode(str));

String updatePasswordModelToJson(UpdatePasswordModel data) => json.encode(data.toJson());

class UpdatePasswordModel {
  UpdatePasswordModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) => UpdatePasswordModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

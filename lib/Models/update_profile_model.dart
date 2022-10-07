// class UpdateProfileModel {
//   int? status;
//   String? profile;
//
//   UpdateProfileModel({this.status, this.profile});
//
//   UpdateProfileModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     profile = json['profile'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['profile'] = this.profile;
//     return data;
//   }
// }


// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    this.status,
    this.profile,
  });

  int? status;
  String? profile;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    status: json["status"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "profile": profile,
  };
}

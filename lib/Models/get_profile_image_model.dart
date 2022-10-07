// class GetProfileImageData {
//   int? id;
//   String? name;
//   var email;
//   String? phone;
//   var emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;
//   var fbId;
//   var gogId;
//   String? emailVerified;
//   String? image;
//   var address;
//   String? dateOfBirth;
//   var city;
//   var state;
//   var zipCode;
//   String? totalFollower;
//   String? gender;
//   String? status;
//   String? activeStatus;
//   String? avatar;
//   String? darkMode;
//   String? messengerColor;
//   var role;
//
//   GetProfileImageData(
//       {this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.emailVerifiedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.fbId,
//         this.gogId,
//         this.emailVerified,
//         this.image,
//         this.address,
//         this.dateOfBirth,
//         this.city,
//         this.state,
//         this.zipCode,
//         this.totalFollower,
//         this.gender,
//         this.status,
//         this.activeStatus,
//         this.avatar,
//         this.darkMode,
//         this.messengerColor,
//         this.role});
//
//   GetProfileImageData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     fbId = json['fb_id'];
//     gogId = json['gog_id'];
//     emailVerified = json['email_verified'];
//     image = json['image'];
//     address = json['address'];
//     dateOfBirth = json['date_of_birth'];
//     city = json['city'];
//     state = json['state'];
//     zipCode = json['zip_code'];
//     totalFollower = json['total_follower'];
//     gender = json['gender'];
//     status = json['status'];
//     activeStatus = json['active_status'];
//     avatar = json['avatar'];
//     darkMode = json['dark_mode'];
//     messengerColor = json['messenger_color'];
//     role = json['role'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['fb_id'] = this.fbId;
//     data['gog_id'] = this.gogId;
//     data['email_verified'] = this.emailVerified;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['zip_code'] = this.zipCode;
//     data['total_follower'] = this.totalFollower;
//     data['gender'] = this.gender;
//     data['status'] = this.status;
//     data['active_status'] = this.activeStatus;
//     data['avatar'] = this.avatar;
//     data['dark_mode'] = this.darkMode;
//     data['messenger_color'] = this.messengerColor;
//     data['role'] = this.role;
//     return data;
//   }
// }


// To parse this JSON data, do
//
//     final getProfileImageDataModel = getProfileImageDataModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final getProfileImageDataModel = getProfileImageDataModelFromJson(jsonString);

import 'dart:convert';

GetProfileImageDataModel getProfileImageDataModelFromJson(String str) => GetProfileImageDataModel.fromJson(json.decode(str));

String getProfileImageDataModelToJson(GetProfileImageDataModel data) => json.encode(data.toJson());

class GetProfileImageDataModel {
  GetProfileImageDataModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  String? status;
  String? message;
  Data? data;

  factory GetProfileImageDataModel.fromJson(Map<String, dynamic> json) => GetProfileImageDataModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.fbId,
    this.gogId,
    this.emailVerified,
    this.image,
    this.address,
    this.dateOfBirth,
    this.city,
    this.state,
    this.zipCode,
    this.totalFollower,
    this.gender,
    this.status,
    this.activeStatus,
    this.avatar,
    this.darkMode,
    this.messengerColor,
    this.role,
    this.totalBalance,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic fbId;
  dynamic gogId;
  String? emailVerified;
  String? image;
  dynamic address;
  dynamic dateOfBirth;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  String? totalFollower;
  String? gender;
  String? status;
  String? activeStatus;
  String? avatar;
  String? darkMode;
  String? messengerColor;
  String? role;
  String? totalBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    fbId: json["fb_id"],
    gogId: json["gog_id"],
    emailVerified: json["email_verified"],
    image: json["image"],
    address: json["address"],
    dateOfBirth: json["date_of_birth"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    totalFollower: json["total_follower"],
    gender: json["gender"],
    status: json["status"],
    activeStatus: json["active_status"],
    avatar: json["avatar"],
    darkMode: json["dark_mode"],
    messengerColor: json["messenger_color"],
    role: json["role"],
    totalBalance: json["total_balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "fb_id": fbId,
    "gog_id": gogId,
    "email_verified": emailVerified,
    "image": image,
    "address": address,
    "date_of_birth": dateOfBirth,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "total_follower": totalFollower,
    "gender": gender,
    "status": status,
    "active_status": activeStatus,
    "avatar": avatar,
    "dark_mode": darkMode,
    "messenger_color": messengerColor,
    "role": role,
    "total_balance": totalBalance,
  };
}

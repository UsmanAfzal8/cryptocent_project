import 'dart:convert';

UploadProfileImageModel uploadProfileImageModelFromJson(String str) => UploadProfileImageModel.fromJson(json.decode(str));

String uploadProfileImageModelToJson(UploadProfileImageModel data) => json.encode(data.toJson());

class UploadProfileImageModel {
  UploadProfileImageModel({
    this.status,
    this.statusCode,
    this.message,
    this.date,
  });

  String? status;
  int? statusCode;
  String? message;
  Date? date;

  factory UploadProfileImageModel.fromJson(Map<String, dynamic> json) => UploadProfileImageModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    date: Date.fromJson(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "date": date!.toJson(),
  };
}

class Date {
  Date({
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
  });

  int? id;
  String? name;
  dynamic email;
  String? phone;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic fbId;
  dynamic gogId;
  String? emailVerified;
  String? image;
  dynamic address;
  DateTime? dateOfBirth;
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
  dynamic role;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
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
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
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
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
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
  };
}


import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.status,
    this.user,
    this.token,
  });

  String? status;
  User? user;
  String? token;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    status: json["status"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user!.toJson(),
    "token": token,
  };
}

class User {
  User({
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
  dynamic dateOfBirth;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  String? totalFollower;
  dynamic gender;
  String? status;
  String? activeStatus;
  String? avatar;
  String? darkMode;
  String? messengerColor;
  dynamic role;
  String? totalBalance;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
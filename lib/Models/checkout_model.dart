// To parse this JSON data, do
//
//     final checkOutModel = checkOutModelFromJson(jsonString);

import 'dart:convert';

CheckOutModel checkOutModelFromJson(String str) => CheckOutModel.fromJson(json.decode(str));

String checkOutModelToJson(CheckOutModel data) => json.encode(data.toJson());

class CheckOutModel {
  CheckOutModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  String? status;
  int? statusCode;
  String? message;
  Data? data;

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.quantity,
    this.grossTotal,
    this.discount,
    this.netTotal,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? quantity;
  String? grossTotal;
  String? discount;
  String? netTotal;
  String? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    quantity: json["quantity"],
    grossTotal: json["gross_total"],
    discount: json["discount"],
    netTotal: json["net_total"],
    userId: json["user_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "gross_total": grossTotal,
    "discount": discount,
    "net_total": netTotal,
    "user_id": userId,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}

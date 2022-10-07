
import 'dart:convert';

ProductUploadModel productUploadModelFromJson(String str) => ProductUploadModel.fromJson(json.decode(str));

String productUploadModelToJson(ProductUploadModel data) => json.encode(data.toJson());

class ProductUploadModel {
  ProductUploadModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  int? statusCode;
  String? status;
  Data? data;
  String? message;

  factory ProductUploadModel.fromJson(Map<String, dynamic> json) => ProductUploadModel(
    statusCode: json["statusCode"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.categoryId,
    this.title,
    this.description,
    this.price,
    this.saleType,
    this.shipping,
    this.internationalShipping,
    this.acutionDays,
    this.userId,
    this.subCategoryId,
    this.productimage,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? categoryId;
  String? title;
  String? description;
  String? price;
  String? saleType;
  String? shipping;
  String? internationalShipping;
  String? acutionDays;
  String? userId;
  String? subCategoryId;
  String? productimage;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryId: json["category_id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    saleType: json["sale_type"],
    shipping: json["shipping"],
    internationalShipping: json["international_shipping"],
    acutionDays: json["acution_days"],
    userId: json["user_id"],
    subCategoryId: json["sub_category_id"],
    productimage: json["productimage"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "title": title,
    "description": description,
    "price": price,
    "sale_type": saleType,
    "shipping": shipping,
    "international_shipping": internationalShipping,
    "acution_days": acutionDays,
    "user_id": userId,
    "sub_category_id": subCategoryId,
    "productimage": productimage,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}


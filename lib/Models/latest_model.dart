import 'dart:convert';

class LatestModel {
  int? id;
  String? categoryId;
  String? title;
  String? description;
  String? price;
  String? review;
  String? saleType;
  String? internationalShipping;
  String? shipping;
  String? acutionDays;
  String? status;
  String? productimage;
  bool? favourite = false;
  List<dynamic>? productimageList;
  var subCategoryId;
  var userId;
  String? createdAt;
  String? updatedAt;

  LatestModel(
      {this.id,
      this.categoryId,
      this.title,
      this.description,
      this.price,
      this.review,
      this.saleType,
      this.internationalShipping,
      this.shipping,
      this.acutionDays,
      this.favourite,
      this.status,
      this.productimage,
      this.subCategoryId,
      this.userId,
      this.createdAt,
      this.productimageList,
      this.updatedAt});

  LatestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    review = json['review'];
    saleType = json['sale_type'];
    internationalShipping = json['international_shipping'];
    shipping = json['shipping'];
    acutionDays = json['acution_days'];
    status = json['status'];
    productimage = json['productimage'];
    productimageList = jsonDecode(json['productimage']);
    subCategoryId = json['sub_category_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    favourite = false;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['review'] = this.review;
    data['sale_type'] = this.saleType;
    data['international_shipping'] = this.internationalShipping;
    data['shipping'] = this.shipping;
    data['acution_days'] = this.acutionDays;
    data['status'] = this.status;
    data['productimage'] = this.productimage;
    data['sub_category_id'] = this.subCategoryId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

import 'dart:convert';

class PopularModel {
  int? id;
  String? categoryId;
  String? title;
  String? description;
  String? saleType;
  String? internationalShipping;
  String? shipping;
  String? acutionDays;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? subCategoryId;
  String? productimage;
  List<dynamic>? productimageList;
  String? price;
  bool? favourite = false;
  String? userId;
  String? review;

  PopularModel(
      {this.id,
      this.categoryId,
      this.title,
      this.description,
      this.saleType,
      this.internationalShipping,
      this.shipping,
      this.acutionDays,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subCategoryId,
      this.productimage,
      this.price,
      this.userId,
      this.favourite,
      this.productimageList,
      this.review});

  PopularModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favourite = false;
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    saleType = json['sale_type'];
    internationalShipping = json['international_shipping'];
    shipping = json['shipping'];
    acutionDays = json['acution_days'];
    status = json['status'];
    favourite = json['favourite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategoryId = json['sub_category_id'];
    productimage = (json['productimage']);
    productimageList = jsonDecode(json['productimage']);
    //productimageList = productimage;
    price = json['price'];
    userId = json['user_id'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['sale_type'] = this.saleType;
    data['international_shipping'] = this.internationalShipping;
    data['shipping'] = this.shipping;
    data['acution_days'] = this.acutionDays;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sub_category_id'] = this.subCategoryId;
    data['productimage'] = this.productimage;
    data['price'] = this.price;
    data['favourite'] = this.favourite;
    data['user_id'] = this.userId;
    data['review'] = this.review;
    return data;
  }
}

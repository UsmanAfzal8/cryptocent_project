import 'dart:convert';

class ProductSubCategory {
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
  bool? favourite = false;
  List<dynamic>? productimageList;
  String? price;
  var userId;
  String? review;
  Category? category;

  ProductSubCategory(
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
      this.review,
      this.favourite,
      this.productimageList,
      this.category});

  ProductSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    saleType = json['sale_type'];
    internationalShipping = json['international_shipping'];
    shipping = json['shipping'];
    acutionDays = json['acution_days'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategoryId = json['sub_category_id'];
    productimage = json['productimage'];
    productimageList = jsonDecode(json['productimage']);
    price = json['price'];
    userId = json['user_id'];
    review = json['review'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    favourite = false;
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
    data['user_id'] = this.userId;
    data['review'] = this.review;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  Null? parentCategoryId;
  String? catImg;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.parentCategoryId,
      this.catImg,
      this.name,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCategoryId = json['parent_category_id'];
    catImg = json['cat_img'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_category_id'] = this.parentCategoryId;
    data['cat_img'] = this.catImg;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

import 'dart:convert';

class OrderHistoryData {
  int? id;
  String? userId;
  String? quantity;
  String? grossTotal;
  String? discount;
  String? netTotal;
  String? createdAt;
  String? updatedAt;
  String? status;
  List<CheckoutProducts>? checkoutProducts;

  OrderHistoryData(
      {this.id,
        this.userId,
        this.quantity,
        this.grossTotal,
        this.discount,
        this.netTotal,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.checkoutProducts,});

  OrderHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    grossTotal = json['gross_total'];
    discount = json['discount'];
    netTotal = json['net_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    if (json['checkout_products'] != null) {
      checkoutProducts = <CheckoutProducts>[];
      json['checkout_products'].forEach((v) {
        checkoutProducts!.add(new CheckoutProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['gross_total'] = this.grossTotal;
    data['discount'] = this.discount;
    data['net_total'] = this.netTotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.checkoutProducts != null) {
      data['checkout_products'] =
          this.checkoutProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckoutProducts {
  int? id;
  String? productId;
  String? userId;
  String? checkoutId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  CheckoutProducts(
      {this.id,
        this.productId,
        this.userId,
        this.checkoutId,
        this.createdAt,
        this.updatedAt,
        this.product});

  CheckoutProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    checkoutId = json['checkout_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['checkout_id'] = this.checkoutId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
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
  String? price;
  String? userId;
  String? review;
  List<dynamic>? myImages = [];

  Product(
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
        this.review, this.myImages});

  Product.fromJson(Map<String, dynamic> json) {
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
    myImages = jsonDecode(json['productimage']);
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
    data['user_id'] = this.userId;
    data['review'] = this.review;
    return data;
  }
}

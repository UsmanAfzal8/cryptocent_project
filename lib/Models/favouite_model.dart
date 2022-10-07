// import 'dart:convert';
//
// FavouriteDataModel favouriteDataModelFromJson(String str) => FavouriteDataModel.fromJson(json.decode(str));
//
// String favouriteDataModelToJson(FavouriteDataModel data) => json.encode(data.toJson());
//
// class FavouriteDataModel {
//   FavouriteDataModel({
//     this.statusCode,
//     this.status,
//     this.data,
//   });
//
//   int? statusCode;
//   String? status;
//   List<Datum>? data;
//
//   factory FavouriteDataModel.fromJson(Map<String, dynamic> json) => FavouriteDataModel(
//     statusCode: json["statusCode"],
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "status": status,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.userId,
//     this.productId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//     this.product,
//   });
//
//   int? id;
//   String? userId;
//   String? productId;
//   dynamic status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   User? user;
//   Product? product;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     userId: json["user_id"],
//     productId: json["product_id"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     user: User.fromJson(json["user"]),
//     product: Product.fromJson(json["product"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "product_id": productId,
//     "status": status,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//     "user": user!.toJson(),
//     "product": product!.toJson(),
//   };
// }
//
// class Product {
//   Product({
//     this.id,
//     this.categoryId,
//     this.title,
//     this.description,
//     this.saleType,
//     this.internationalShipping,
//     this.shipping,
//     this.acutionDays,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.subCategoryId,
//     this.productimage,
//     this.price,
//     this.userId,
//     this.review,
//   });
//
//   int? id;
//   String? categoryId;
//   String? title;
//   String? description;
//   String? saleType;
//   String? internationalShipping;
//   String? shipping;
//   String? acutionDays;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? subCategoryId;
//   String? productimage;
//   String? price;
//   String? userId;
//   String? review;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     categoryId: json["category_id"],
//     title: json["title"],
//     description: json["description"],
//     saleType: json["sale_type"],
//     internationalShipping: json["international_shipping"],
//     shipping: json["shipping"],
//     acutionDays: json["acution_days"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     subCategoryId: json["sub_category_id"],
//     productimage: json["productimage"],
//     price: json["price"],
//     userId: json["user_id"],
//     review: json["review"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "category_id": categoryId,
//     "title": title,
//     "description": description,
//     "sale_type": saleType,
//     "international_shipping": internationalShipping,
//     "shipping": shipping,
//     "acution_days": acutionDays,
//     "status": status,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//     "sub_category_id": subCategoryId,
//     "productimage": productimage,
//     "price": price,
//     "user_id": userId,
//     "review": review,
//   };
// }
//
// class User {
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.fbId,
//     this.gogId,
//     this.emailVerified,
//     this.image,
//     this.address,
//     this.dateOfBirth,
//     this.city,
//     this.state,
//     this.zipCode,
//     this.totalFollower,
//     this.gender,
//     this.status,
//     this.activeStatus,
//     this.avatar,
//     this.darkMode,
//     this.messengerColor,
//     this.role,
//   });
//
//   int? id;
//   String? name;
//   String? email;
//   dynamic phone;
//   dynamic emailVerifiedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic fbId;
//   dynamic gogId;
//   String? emailVerified;
//   dynamic image;
//   dynamic address;
//   dynamic dateOfBirth;
//   dynamic city;
//   dynamic state;
//   dynamic zipCode;
//   String? totalFollower;
//   String? gender;
//   String? status;
//   String? activeStatus;
//   String? avatar;
//   String? darkMode;
//   String? messengerColor;
//   dynamic role;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     emailVerifiedAt: json["email_verified_at"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     fbId: json["fb_id"],
//     gogId: json["gog_id"],
//     emailVerified: json["email_verified"],
//     image: json["image"],
//     address: json["address"],
//     dateOfBirth: json["date_of_birth"],
//     city: json["city"],
//     state: json["state"],
//     zipCode: json["zip_code"],
//     totalFollower: json["total_follower"],
//     gender: json["gender"],
//     status: json["status"],
//     activeStatus: json["active_status"],
//     avatar: json["avatar"],
//     darkMode: json["dark_mode"],
//     messengerColor: json["messenger_color"],
//     role: json["role"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "email_verified_at": emailVerifiedAt,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//     "fb_id": fbId,
//     "gog_id": gogId,
//     "email_verified": emailVerified,
//     "image": image,
//     "address": address,
//     "date_of_birth": dateOfBirth,
//     "city": city,
//     "state": state,
//     "zip_code": zipCode,
//     "total_follower": totalFollower,
//     "gender": gender,
//     "status": status,
//     "active_status": activeStatus,
//     "avatar": avatar,
//     "dark_mode": darkMode,
//     "messenger_color": messengerColor,
//     "role": role,
//   };
// }

import 'dart:convert';

class FavoriteProductsData {
  int? id;
  String? userId;
  String? productId;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Product? product;

  FavoriteProductsData(
      {this.id,
        this.userId,
        this.productId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.product});

  FavoriteProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  var email;
  String? phone;
  var emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  var fbId;
  var gogId;
  String? emailVerified;
  var image;
  var address;
  String? dateOfBirth;
  var city;
  var state;
  var zipCode;
  String? totalFollower;
  String? gender;
  String? status;
  String? activeStatus;
  String? avatar;
  String? darkMode;
  String? messengerColor;
  var role;
  String? totalBalance;

  User(
      {this.id,
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
        this.totalBalance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fbId = json['fb_id'];
    gogId = json['gog_id'];
    emailVerified = json['email_verified'];
    image = json['image'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    totalFollower = json['total_follower'];
    gender = json['gender'];
    status = json['status'];
    activeStatus = json['active_status'];
    avatar = json['avatar'];
    darkMode = json['dark_mode'];
    messengerColor = json['messenger_color'];
    role = json['role'];
    totalBalance = json['total_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fb_id'] = this.fbId;
    data['gog_id'] = this.gogId;
    data['email_verified'] = this.emailVerified;
    data['image'] = this.image;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['total_follower'] = this.totalFollower;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['active_status'] = this.activeStatus;
    data['avatar'] = this.avatar;
    data['dark_mode'] = this.darkMode;
    data['messenger_color'] = this.messengerColor;
    data['role'] = this.role;
    data['total_balance'] = this.totalBalance;
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
  List<dynamic>? myFavImages = [];

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
        this.review,
      this.myFavImages});

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
    myFavImages = jsonDecode(json['productimage']);
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
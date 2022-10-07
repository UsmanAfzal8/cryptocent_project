// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Utils/url.dart';
import 'category_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

NewCategoryModel categoryModelFromJson(String str) =>
    NewCategoryModel.fromJson(json.decode(str));

String categoryModelToJson(NewCategoryModel data) => json.encode(data.toJson());

class NewCategoryModel {
  NewCategoryModel({
    required this.statusCode,
    required this.status,
    required this.show,
  });

  int statusCode;
  String status;
  List<Show> show;

  factory NewCategoryModel.fromJson(Map<String, dynamic> json) =>
      NewCategoryModel(
        statusCode: json["statusCode"],
        status: json["status"],
        show: List<Show>.from(json["show"].map((x) => Show.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "show": List<dynamic>.from(show.map((x) => x.toJson())),
      };
}

class Show {
  Show({
    required this.id,
    required this.parentCategoryId,
    required this.catImg,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic parentCategoryId;
  String catImg;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        parentCategoryId: json["parent_category_id"],
        catImg: json["cat_img"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_category_id": parentCategoryId,
        "cat_img": catImg,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CallCategoriesApi {
  getcategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('userToken');
    print('iddddd=$id');
    print('calling api');
    print(categoriesUrl);
    http.Response response = await http.get(Uri.parse(categoriesUrl));
    //return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
    print('ppppp' + response.body.toString());
    var data1 = jsonDecode(response.body);
    List<Show> data = NewCategoryModel.fromJson(data1).show;
    final activity = categoryModelFromJson(response.body);
    print('response===' + activity.toString());
    return activity;
  }
}

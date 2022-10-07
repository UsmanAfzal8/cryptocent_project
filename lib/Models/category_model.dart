class CategoriesModel {
  int? id;
  var parentCategoryId;
  String? catImg;
  String? name;
  String? createdAt;
  String? updatedAt;

  CategoriesModel(
      {this.id,
      this.parentCategoryId,
      this.catImg,
      this.name,
      this.createdAt,
      this.updatedAt});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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

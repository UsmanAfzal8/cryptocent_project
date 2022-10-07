class SubCategoryModel {
  int? id;
  String? parentCategoryId;
  String? catImg;
  String? name;
  String? createdAt;
  String? updatedAt;

  SubCategoryModel(
      {this.id,
      this.parentCategoryId,
      this.catImg,
      this.name,
      this.createdAt,
      this.updatedAt});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
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

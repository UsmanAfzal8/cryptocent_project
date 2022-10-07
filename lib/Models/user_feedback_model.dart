class UserFeedBackData {
  String? review;
  String? comment;
  String? productId;
  String? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserFeedBackData(
      {this.review,
        this.comment,
        this.productId,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserFeedBackData.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    comment = json['comment'];
    productId = json['product_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['comment'] = this.comment;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}


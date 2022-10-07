class MyReviewsData {
  int? id;
  String? review;
  String? comment;
  String? userId;
  String? productId;
  String? createdAt;
  String? updatedAt;

  MyReviewsData(
      {this.id,
        this.review,
        this.comment,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt});

  MyReviewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    comment = json['comment'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
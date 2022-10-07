class FaqsModel {
  int? id;
  String? faqsTitle;
  String? faqsAnswer;
  String? createdAt;
  String? updatedAt;

  FaqsModel(
      {this.id,
      this.faqsTitle,
      this.faqsAnswer,
      this.createdAt,
      this.updatedAt});

  FaqsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    faqsTitle = json['faqs_title'];
    faqsAnswer = json['faqs_answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['faqs_title'] = this.faqsTitle;
    data['faqs_answer'] = this.faqsAnswer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

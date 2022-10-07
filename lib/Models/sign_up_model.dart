class SignUpModel {
  String? status;
  User? user;
  String? token;

  SignUpModel({this.status, this.user, this.token});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String? name;
  String? phone;
  String? updatedAt;
  String? createdAt;
  int? id;

  User({this.name, this.phone, this.updatedAt, this.createdAt, this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
class ViewAddressModel {
  int? id;
  String? userId;
  String? name;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? createdAt;
  String? updatedAt;

  ViewAddressModel(
      {this.id,
      this.userId,
      this.name,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.zipCode,
      this.createdAt,
      this.updatedAt});

  ViewAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

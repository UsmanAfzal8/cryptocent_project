class NearCenterModel {
  int? id;
  var address;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;

  NearCenterModel(
      {this.id,
      this.address,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

  NearCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

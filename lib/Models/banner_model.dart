class BannerModel {
  String? img;

  BannerModel({this.img});

  BannerModel.fromJson(Map<String, dynamic> json) {
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    return data;
  }
}

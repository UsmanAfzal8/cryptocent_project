// class AddFollowerData {
//   String? followerId;
//   String? followedId;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//
//   AddFollowerData({this.followerId,
//     this.followedId,
//     this.updatedAt,
//     this.createdAt,
//     this.id});
//
//   AddFollowerData.fromJson(Map<String, dynamic> json) {
//     followerId = json['follower_id'];
//     followedId = json['followed_id'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['follower_id'] = this.followerId;
//     data['followed_id'] = this.followedId;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }

class AddFollower {
  AddFollowerData? data;
  int? statusCode;
  String? status;
  String? message;

  AddFollower({this.data, this.statusCode, this.status, this.message});

  AddFollower.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AddFollowerData.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class AddFollowerData {
  String? followerId;
  String? followedId;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddFollowerData(
      {this.followerId,
        this.followedId,
        this.updatedAt,
        this.createdAt,
        this.id});

  AddFollowerData.fromJson(Map<String, dynamic> json) {
    followerId = json['follower_id'];
    followedId = json['followed_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follower_id'] = this.followerId;
    data['followed_id'] = this.followedId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
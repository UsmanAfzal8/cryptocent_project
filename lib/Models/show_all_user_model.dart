
class ShowAllUsersDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  var emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  var fbId;
  var gogId;
  String? emailVerified;
  String? image;
  String? address;
  String? dateOfBirth;
  String? city;
  String? state;
  String? zipCode;
  String? totalFollower;
  String? gender;
  String? status;
  String? activeStatus;
  String? avatar;
  String? darkMode;
  String? messengerColor;
  String? role;

  ShowAllUsersDataModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.fbId,
        this.gogId,
        this.emailVerified,
        this.image,
        this.address,
        this.dateOfBirth,
        this.city,
        this.state,
        this.zipCode,
        this.totalFollower,
        this.gender,
        this.status,
        this.activeStatus,
        this.avatar,
        this.darkMode,
        this.messengerColor,
        this.role});

  ShowAllUsersDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fbId = json['fb_id'];
    gogId = json['gog_id'];
    emailVerified = json['email_verified'];
    image = json['image'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    totalFollower = json['total_follower'];
    gender = json['gender'];
    status = json['status'];
    activeStatus = json['active_status'];
    avatar = json['avatar'];
    darkMode = json['dark_mode'];
    messengerColor = json['messenger_color'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fb_id'] = this.fbId;
    data['gog_id'] = this.gogId;
    data['email_verified'] = this.emailVerified;
    data['image'] = this.image;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['total_follower'] = this.totalFollower;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['active_status'] = this.activeStatus;
    data['avatar'] = this.avatar;
    data['dark_mode'] = this.darkMode;
    data['messenger_color'] = this.messengerColor;
    data['role'] = this.role;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
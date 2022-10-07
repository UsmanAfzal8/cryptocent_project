// class AllChatMessagesModel {
//   int? statusCode;
//   String? status;
//   List<Data>? data;
//   String? message;
//
//   AllChatMessagesModel({this.statusCode, this.status, this.data, this.message});
//
//   AllChatMessagesModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? senderId;
//   String? receiverId;
//   String? conversationId;
//   var messageParentId;
//   String? message;
//   String? attachment;
//   String? seenStatus;
//   String? createdAt;
//   String? updatedAt;
//   Sender? sender;
//   Receiver? receiver;
//
//   Data(
//       {this.id,
//         this.senderId,
//         this.receiverId,
//         this.conversationId,
//         this.messageParentId,
//         this.message,
//         this.attachment,
//         this.seenStatus,
//         this.createdAt,
//         this.updatedAt,
//         this.sender,
//         this.receiver});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     senderId = json['sender_id'];
//     receiverId = json['receiver_id'];
//     conversationId = json['conversation_id'];
//     messageParentId = json['message_parent_id'];
//     message = json['message'];
//     attachment = json['attachment'];
//     seenStatus = json['seen_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     sender =
//     json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
//     receiver = json['receiver'] != null
//         ? new Receiver.fromJson(json['receiver'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['sender_id'] = this.senderId;
//     data['receiver_id'] = this.receiverId;
//     data['conversation_id'] = this.conversationId;
//     data['message_parent_id'] = this.messageParentId;
//     data['message'] = this.message;
//     data['attachment'] = this.attachment;
//     data['seen_status'] = this.seenStatus;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.sender != null) {
//       data['sender'] = this.sender!.toJson();
//     }
//     if (this.receiver != null) {
//       data['receiver'] = this.receiver!.toJson();
//     }
//     return data;
//   }
// }
//
// class Sender {
//   int? id;
//   String? name;
//   var email;
//   String? phone;
//   var emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;
//   var fbId;
//   var gogId;
//   String? emailVerified;
//   var image;
//   var address;
//   var dateOfBirth;
//   var city;
//   var state;
//   var zipCode;
//   String? totalFollower;
//   var gender;
//   String? status;
//   String? activeStatus;
//   String? avatar;
//   String? darkMode;
//   String? messengerColor;
//   var role;
//
//   Sender(
//       {this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.emailVerifiedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.fbId,
//         this.gogId,
//         this.emailVerified,
//         this.image,
//         this.address,
//         this.dateOfBirth,
//         this.city,
//         this.state,
//         this.zipCode,
//         this.totalFollower,
//         this.gender,
//         this.status,
//         this.activeStatus,
//         this.avatar,
//         this.darkMode,
//         this.messengerColor,
//         this.role});
//
//   Sender.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     fbId = json['fb_id'];
//     gogId = json['gog_id'];
//     emailVerified = json['email_verified'];
//     image = json['image'];
//     address = json['address'];
//     dateOfBirth = json['date_of_birth'];
//     city = json['city'];
//     state = json['state'];
//     zipCode = json['zip_code'];
//     totalFollower = json['total_follower'];
//     gender = json['gender'];
//     status = json['status'];
//     activeStatus = json['active_status'];
//     avatar = json['avatar'];
//     darkMode = json['dark_mode'];
//     messengerColor = json['messenger_color'];
//     role = json['role'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['fb_id'] = this.fbId;
//     data['gog_id'] = this.gogId;
//     data['email_verified'] = this.emailVerified;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['zip_code'] = this.zipCode;
//     data['total_follower'] = this.totalFollower;
//     data['gender'] = this.gender;
//     data['status'] = this.status;
//     data['active_status'] = this.activeStatus;
//     data['avatar'] = this.avatar;
//     data['dark_mode'] = this.darkMode;
//     data['messenger_color'] = this.messengerColor;
//     data['role'] = this.role;
//     return data;
//   }
// }
//
// class Receiver {
//   int? id;
//   String? name;
//   String? email;
//   var phone;
//   var emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;
//   var fbId;
//   var gogId;
//   String? emailVerified;
//   var image;
//   var address;
//   var dateOfBirth;
//   var city;
//   var state;
//   var zipCode;
//   String? totalFollower;
//   String? gender;
//   String? status;
//   String? activeStatus;
//   String? avatar;
//   String? darkMode;
//   String? messengerColor;
//   var role;
//
//   Receiver(
//       {this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.emailVerifiedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.fbId,
//         this.gogId,
//         this.emailVerified,
//         this.image,
//         this.address,
//         this.dateOfBirth,
//         this.city,
//         this.state,
//         this.zipCode,
//         this.totalFollower,
//         this.gender,
//         this.status,
//         this.activeStatus,
//         this.avatar,
//         this.darkMode,
//         this.messengerColor,
//         this.role});
//
//   Receiver.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     fbId = json['fb_id'];
//     gogId = json['gog_id'];
//     emailVerified = json['email_verified'];
//     image = json['image'];
//     address = json['address'];
//     dateOfBirth = json['date_of_birth'];
//     city = json['city'];
//     state = json['state'];
//     zipCode = json['zip_code'];
//     totalFollower = json['total_follower'];
//     gender = json['gender'];
//     status = json['status'];
//     activeStatus = json['active_status'];
//     avatar = json['avatar'];
//     darkMode = json['dark_mode'];
//     messengerColor = json['messenger_color'];
//     role = json['role'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['fb_id'] = this.fbId;
//     data['gog_id'] = this.gogId;
//     data['email_verified'] = this.emailVerified;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['zip_code'] = this.zipCode;
//     data['total_follower'] = this.totalFollower;
//     data['gender'] = this.gender;
//     data['status'] = this.status;
//     data['active_status'] = this.activeStatus;
//     data['avatar'] = this.avatar;
//     data['dark_mode'] = this.darkMode;
//     data['messenger_color'] = this.messengerColor;
//     data['role'] = this.role;
//     return data;
//   }
// }


class AllUserChatData {
  int? id;
  String? senderId;
  String? receiverId;
  String? conversationId;
  var messageParentId;
  String? message;
  String? attachment;
  String? seenStatus;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Receiver? receiver;

  AllUserChatData(
      {this.id,
        this.senderId,
        this.receiverId,
        this.conversationId,
        this.messageParentId,
        this.message,
        this.attachment,
        this.seenStatus,
        this.createdAt,
        this.updatedAt,
        this.sender,
        this.receiver});

  AllUserChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    conversationId = json['conversation_id'];
    messageParentId = json['message_parent_id'];
    message = json['message'];
    attachment = json['attachment'];
    seenStatus = json['seen_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['conversation_id'] = this.conversationId;
    data['message_parent_id'] = this.messageParentId;
    data['message'] = this.message;
    data['attachment'] = this.attachment;
    data['seen_status'] = this.seenStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    return data;
  }
}

class Sender {
  int? id;
  String? name;
  var email;
  String? phone;
  var emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  var fbId;
  var gogId;
  String? emailVerified;
  var image;
  var address;
  var dateOfBirth;
  var city;
  var state;
  var zipCode;
  String? totalFollower;
  var gender;
 String? status;
  String? activeStatus;
  String? avatar;
  String? darkMode;
  String? messengerColor;
  var role;

  Sender(
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

  Sender.fromJson(Map<String, dynamic> json) {
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

class Receiver {
  int? id;
  String? name;
  String? email;
  var phone;
  var emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  var fbId;
  var gogId;
  String? emailVerified;
  var image;
  var address;
  var dateOfBirth;
  var city;
  var state;
  var zipCode;
  String? totalFollower;
  String? gender;
  String? status;
  String? activeStatus;
  String? avatar;
  String? darkMode;
  String? messengerColor;
  var role;

  Receiver(
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

  Receiver.fromJson(Map<String, dynamic> json) {
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
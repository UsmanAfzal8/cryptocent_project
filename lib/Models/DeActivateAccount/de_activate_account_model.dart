class DeActivateAccountModel {
  int? statusCode;
  String? status;
  String? accountStatus;
  String? message;

  DeActivateAccountModel(
      {this.statusCode, this.status, this.accountStatus, this.message});

  DeActivateAccountModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    accountStatus = json['accountStatus'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['accountStatus'] = this.accountStatus;
    data['message'] = this.message;
    return data;
  }
}

//
// import 'dart:convert';
//
// DeActivateAccountModel deActivateAccountModelFromJson(String str) => DeActivateAccountModel.fromJson(json.decode(str));
//
// String deActivateAccountModelToJson(DeActivateAccountModel data) => json.encode(data.toJson());
//
// class DeActivateAccountModel {
//   DeActivateAccountModel({
//     this.statusCode,
//     this.status,
//     this.accountStatus,
//     this.message,
//   });
//
//   int? statusCode;
//   String? status;
//   String? accountStatus;
//   String? message;
//
//   factory DeActivateAccountModel.fromJson(Map<String, dynamic> json) => DeActivateAccountModel(
//     statusCode: json["statusCode"],
//     status: json["status"],
//     accountStatus: json["accountStatus"],
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "status": status,
//     "accountStatus": accountStatus,
//     "message": message,
//   };
// }

// // To parse this JSON data, do
// //
// //     final updateAddressModel = updateAddressModelFromJson(jsonString);
//
// import 'dart:convert';
//
// UpdateAddressModel updateAddressModelFromJson(String str) => UpdateAddressModel.fromJson(json.decode(str));
//
// String updateAddressModelToJson(UpdateAddressModel data) => json.encode(data.toJson());
//
// class UpdateAddressModel {
//   UpdateAddressModel({
//     this.status,
//     this.statusCode,
//     this.message,
//   });
//
//   String? status;
//   int? statusCode;
//   String? message;
//
//   factory UpdateAddressModel.fromJson(Map<String, dynamic> json) => UpdateAddressModel(
//     status: json["status"],
//     statusCode: json["statusCode"],
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "statusCode": statusCode,
//     "message": message,
//   };
// }

class UpdatePasswordModel {
  String? status;
  String? message;

  UpdatePasswordModel({this.status, this.message});

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

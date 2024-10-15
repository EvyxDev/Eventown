import 'data.dart';

class SignUpModel {
  String? status;
  Data? data;

  SignUpModel({this.status, this.data});

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

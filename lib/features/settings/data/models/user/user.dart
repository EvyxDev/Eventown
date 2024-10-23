import 'data.dart';

class UserModel {
  Data? data;

  UserModel({this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

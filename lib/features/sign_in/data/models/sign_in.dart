import 'data.dart';

class SignInModel {
  Data? data;
  String? token;

  SignInModel({this.data, this.token});

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'token': token,
      };
}

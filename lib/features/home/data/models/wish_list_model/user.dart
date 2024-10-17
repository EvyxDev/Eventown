import 'interest.dart';

class User {
  String? id;
  String? name;
  List<Interest>? interests;

  User({this.id, this.name, this.interests});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        interests: (json['interests'] as List<dynamic>?)
            ?.map((e) => Interest.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'interests': interests?.map((e) => e.toJson()).toList(),
      };
}

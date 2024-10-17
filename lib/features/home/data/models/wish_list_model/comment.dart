import 'user.dart';

class Comment {
  String? id;
  User? user;
  String? text;

  Comment({this.id, this.user, this.text});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['_id'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        text: json['text'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user?.toJson(),
        'text': text,
      };
}

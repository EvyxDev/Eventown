import 'user.dart';

class Comment {
  String? id;
  User? user;
  String? text;
  String? img;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Comment({
    this.id,
    this.user,
    this.text,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['_id'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        text: json['text'] as String?,
        img: json['img'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user?.toJson(),
        'text': text,
        'img': img,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}

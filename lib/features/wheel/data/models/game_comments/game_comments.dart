import 'comment.dart';

class GameComments {
  bool? success;
  List<Comment>? comments;

  GameComments({this.success, this.comments});

  factory GameComments.fromJson(Map<String, dynamic> json) => GameComments(
        success: json['success'] as bool?,
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'comments': comments?.map((e) => e.toJson()).toList(),
      };
}

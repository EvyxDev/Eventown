import 'user_information.dart';

class MyHistory {
  UserInformation? userInformation;
  String? id;
  String? loggedUser;
  List<String>? events;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyHistory({
    this.userInformation,
    this.id,
    this.loggedUser,
    this.events,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyHistory.fromJson(Map<String, dynamic> json) => MyHistory(
        userInformation: json['userInformation'] == null
            ? null
            : UserInformation.fromJson(
                json['userInformation'] as Map<String, dynamic>),
        id: json['_id'] as String?,
        loggedUser: json['loggedUser'] as String?,
        events: json['events'] as List<String>?,
        status: json['status'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'userInformation': userInformation?.toJson(),
        '_id': id,
        'loggedUser': loggedUser,
        'events': events,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}

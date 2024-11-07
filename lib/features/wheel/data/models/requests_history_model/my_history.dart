import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'logged_user.dart';
import 'user_information.dart';

class MyHistory {
  String? id;
  UserInformation? userInformation;
  LoggedUser? loggedUser;
  List<EventModel>? events;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyHistory({
    this.id,
    this.userInformation,
    this.loggedUser,
    this.events,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory MyHistory.fromJson(Map<String, dynamic> json) => MyHistory(
        id: json['_id'] as String?,
        userInformation: json['userInformation'] == null
            ? null
            : UserInformation.fromJson(
                json['userInformation'] as Map<String, dynamic>),
        loggedUser: json['loggedUser'] == null
            ? null
            : LoggedUser.fromJson(json['loggedUser'] as Map<String, dynamic>),
        events: (json['events'] as List<dynamic>?)
            ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['status'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userInformation': userInformation?.toJson(),
        'loggedUser': loggedUser?.toJson(),
        'events': events?.map((e) => e.toJson()).toList(),
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

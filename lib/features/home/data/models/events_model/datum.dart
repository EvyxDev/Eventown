import 'package:eventown/features/home/data/models/wish_list_model/comment.dart';
import 'event_category.dart';

class EventModel {
  String? id;
  String? organizerName;
  String? organizationName;
  String? organizationPhoneNumber;
  String? organizationEmail;
  String? organizationWebsite;
  String? organizerPlan;
  String? eventName;
  String? eventAddress;
  List<EventCategory>? eventCategory;
  DateTime? eventDate;
  DateTime? eventStartTime;
  DateTime? eventEndTime;
  String? eventLocation;
  String? eventPlace;
  String? eventImage;
  String? ticketEventLink;
  double? eventPrice;
  String? eventDescription;
  String? eventStatus;
  int? numberOfGoingUsers;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? expirePlanDate;
  List<Comment>? comments;

  EventModel({
    this.id,
    this.organizerName,
    this.organizationName,
    this.organizationPhoneNumber,
    this.organizationEmail,
    this.organizationWebsite,
    this.organizerPlan,
    this.eventName,
    this.eventAddress,
    this.eventCategory,
    this.eventDate,
    this.eventStartTime,
    this.eventEndTime,
    this.eventLocation,
    this.eventPlace,
    this.eventImage,
    this.ticketEventLink,
    this.eventPrice,
    this.eventDescription,
    this.eventStatus,
    this.numberOfGoingUsers,
    this.createdAt,
    this.updatedAt,
    this.expirePlanDate,
    this.comments,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['_id'] as String?,
        organizerName: json['organizerName'] as String?,
        organizationName: json['organizationName'] as String?,
        organizationPhoneNumber: json['organizationPhoneNumber'] as String?,
        organizationEmail: json['organizationEmail'] as String?,
        organizationWebsite: json['organizationWebsite'] as String?,
        organizerPlan: json['organizerPlan'] as String?,
        eventName: json['eventName'] as String?,
        eventAddress: json['eventAddress'] as String?,
        eventCategory: (json['eventCategory'] as List<dynamic>?)
            ?.map((e) => EventCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        eventDate: json['eventDate'] == null
            ? null
            : DateTime.parse(json['eventDate'] as String),
        eventStartTime: json['eventStartTime'] == null
            ? null
            : DateTime.parse(json['eventStartTime'] as String),
        eventEndTime: json['eventEndTime'] == null
            ? null
            : DateTime.parse(json['eventEndTime'] as String),
        eventLocation: json['eventLocation'] as String?,
        eventPlace: json['eventPlace'] as String?,
        eventImage: json['eventImage'] as String?,
        ticketEventLink: json['ticketEventLink'] as String?,
        eventPrice: (json['eventPrice'] as num?)?.toDouble(),
        eventDescription: json['eventDescription'] as String?,
        eventStatus: json['eventStatus'] as String?,
        numberOfGoingUsers: json['numberOfGoingUsers'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        expirePlanDate: json['expirePlanDate'] == null
            ? null
            : DateTime.parse(json['expirePlanDate'] as String),
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'organizerName': organizerName,
        'organizationName': organizationName,
        'organizationPhoneNumber': organizationPhoneNumber,
        'organizationEmail': organizationEmail,
        'organizationWebsite': organizationWebsite,
        'organizerPlan': organizerPlan,
        'eventName': eventName,
        'eventAddress': eventAddress,
        'eventCategory': eventCategory?.map((e) => e.toJson()).toList(),
        'eventDate': eventDate?.toIso8601String(),
        'eventStartTime': eventStartTime?.toIso8601String(),
        'eventEndTime': eventEndTime?.toIso8601String(),
        'eventLocation': eventLocation,
        'eventPlace': eventPlace,
        'eventImage': eventImage,
        'ticketEventLink': ticketEventLink,
        'eventPrice': eventPrice,
        'eventDescription': eventDescription,
        'eventStatus': eventStatus,
        'numberOfGoingUsers': numberOfGoingUsers,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'expirePlanDate': expirePlanDate?.toIso8601String(),
        'comments': comments,
      };
}

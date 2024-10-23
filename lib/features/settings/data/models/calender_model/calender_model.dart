import 'package:eventown/features/home/data/models/events_model/datum.dart';

class CalenderModel {
  String? status;
  int? result;
  List<EventModel>? data;

  CalenderModel({this.status, this.result, this.data});

  factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
        status: json['status'] as String?,
        result: json['result'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'result': result,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

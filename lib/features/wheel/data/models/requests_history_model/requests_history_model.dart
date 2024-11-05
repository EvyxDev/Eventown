import 'my_history.dart';

class RequestsHistoryModel {
  bool? success;
  List<MyHistory>? myHistory;

  RequestsHistoryModel({this.success, this.myHistory});

  factory RequestsHistoryModel.fromJson(Map<String, dynamic> json) {
    return RequestsHistoryModel(
      success: json['success'] as bool?,
      myHistory: (json['myHistory'] as List<dynamic>?)
          ?.map((e) => MyHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'myHistory': myHistory?.map((e) => e.toJson()).toList(),
      };
}

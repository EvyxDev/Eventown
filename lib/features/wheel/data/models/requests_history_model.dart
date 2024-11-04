class RequestsHistoryModel {
  bool? success;
  List<dynamic>? myHistory;

  RequestsHistoryModel({this.success, this.myHistory});

  factory RequestsHistoryModel.fromJson(Map<String, dynamic> json) {
    return RequestsHistoryModel(
      success: json['success'] as bool?,
      myHistory: json['myHistory'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'myHistory': myHistory,
      };
}

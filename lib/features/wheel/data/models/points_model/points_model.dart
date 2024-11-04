import 'my_points.dart';

class PointsModel {
  bool? success;
  MyPoints? myPoints;

  PointsModel({this.success, this.myPoints});

  factory PointsModel.fromJson(Map<String, dynamic> json) => PointsModel(
        success: json['success'] as bool?,
        myPoints: json['myPoints'] == null
            ? null
            : MyPoints.fromJson(json['myPoints'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'myPoints': myPoints?.toJson(),
      };
}

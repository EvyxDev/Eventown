class MyPoints {
  String? id;
  String? user;
  int? points;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyPoints({
    this.id,
    this.user,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyPoints.fromJson(Map<String, dynamic> json) => MyPoints(
        id: json['_id'] as String?,
        user: json['user'] as String?,
        points: json['points'] as int?,
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
        'user': user,
        'points': points,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}

class Category {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({this.id, this.title, this.createdAt, this.updatedAt});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

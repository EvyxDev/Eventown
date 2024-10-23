class EventCategory {
  String? id;
  String? title;

  EventCategory({this.id, this.title});

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
        id: json['_id'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
      };
}

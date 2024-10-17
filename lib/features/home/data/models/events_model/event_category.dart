class EventCategory {
  final String? id;
  final String? title;
  EventCategory(this.id, this.title);
  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      json['_id'] as String?,
      json['title'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
    };
  }
}

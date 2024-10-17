class Interest {
  String? id;
  String? title;

  Interest({this.id, this.title});

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json['_id'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
      };
}

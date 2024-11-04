class User {
  String? id;
  String? name;
  String? email;
  List<dynamic>? interests;
  String? profileImg;

  User({this.id, this.name, this.email, this.interests, this.profileImg});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        interests: json['interests'] as List<dynamic>?,
        profileImg: json['profileImg'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'interests': interests,
        'profileImg': profileImg,
      };
}

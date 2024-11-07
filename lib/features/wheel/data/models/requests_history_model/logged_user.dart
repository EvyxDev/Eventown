class LoggedUser {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? profileImg;
  String? role;

  LoggedUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImg,
    this.role,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) => LoggedUser(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        profileImg: json['profileImg'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profileImg': profileImg,
        'role': role,
      };
}

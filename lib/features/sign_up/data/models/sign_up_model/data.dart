class Data {
  String? name;
  String? email;
  String? location;
  String? gender;
  String? phone;
  List<dynamic>? interests;
  String? slug;
  bool? isOAuthUser;
  bool? emailVerified;
  String? role;
  List<dynamic>? wishlist;
  List<dynamic>? calendar;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.name,
    this.email,
    this.location,
    this.gender,
    this.phone,
    this.interests,
    this.slug,
    this.isOAuthUser,
    this.emailVerified,
    this.role,
    this.wishlist,
    this.calendar,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json['name'] as String?,
        email: json['email'] as String?,
        location: json['location'] as String?,
        gender: json['gender'] as String?,
        phone: json['phone'] as String?,
        interests: json['interests'] as List<dynamic>?,
        slug: json['slug'] as String?,
        isOAuthUser: json['isOAuthUser'] as bool?,
        emailVerified: json['emailVerified'] as bool?,
        role: json['role'] as String?,
        wishlist: json['wishlist'] as List<dynamic>?,
        calendar: json['calendar'] as List<dynamic>?,
        id: json['_id'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'location': location,
        'gender': gender,
        'phone': phone,
        'interests': interests,
        'slug': slug,
        'isOAuthUser': isOAuthUser,
        'emailVerified': emailVerified,
        'role': role,
        'wishlist': wishlist,
        'calendar': calendar,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}

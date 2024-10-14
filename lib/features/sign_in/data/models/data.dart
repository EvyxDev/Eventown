class Data {
  String? id;
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
  bool? active;
  List<dynamic>? wishlist;
  List<dynamic>? calendar;
  int? v;
  String? profileImg;

  Data({
    this.id,
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
    this.active,
    this.wishlist,
    this.calendar,
    this.v,
    this.profileImg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['_id'] as String?,
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
        active: json['active'] as bool?,
        wishlist: json['wishlist'] as List<dynamic>?,
        calendar: json['calendar'] as List<dynamic>?,
        v: json['__v'] as int?,
        profileImg: json['profileImg'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
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
        'active': active,
        'wishlist': wishlist,
        'calendar': calendar,
        '__v': v,
        'profileImg': profileImg,
      };
}

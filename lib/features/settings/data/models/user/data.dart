import 'interest.dart';

class Data {
  String? id;
  String? name;
  String? email;
  String? location;
  String? gender;
  String? phone;
  List<Interest>? interests;
  String? slug;
  bool? isOAuthUser;
  bool? emailVerified;
  String? role;
  List<dynamic>? wishlist;
  List<dynamic>? calendar;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? passwordResetVerified;
  String? profileImg;

  Data(
      {this.id,
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
      this.createdAt,
      this.updatedAt,
      this.v,
      this.passwordResetVerified,
      this.profileImg});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        location: json['location'] as String?,
        gender: json['gender'] as String?,
        phone: json['phone'] as String?,
        interests: (json['interests'] as List<dynamic>?)
            ?.map((e) => Interest.fromJson(e as Map<String, dynamic>))
            .toList(),
        slug: json['slug'] as String?,
        isOAuthUser: json['isOAuthUser'] as bool?,
        emailVerified: json['emailVerified'] as bool?,
        role: json['role'] as String?,
        wishlist: json['wishlist'] as List<dynamic>?,
        calendar: json['calendar'] as List<dynamic>?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        passwordResetVerified: json['passwordResetVerified'] as bool?,
        profileImg: json['profileImg'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'location': location,
        'gender': gender,
        'phone': phone,
        'interests': interests?.map((e) => e.toJson()).toList(),
        'slug': slug,
        'isOAuthUser': isOAuthUser,
        'emailVerified': emailVerified,
        'role': role,
        'wishlist': wishlist,
        'calendar': calendar,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'passwordResetVerified': passwordResetVerified,
        'profileImg': profileImg
      };
}

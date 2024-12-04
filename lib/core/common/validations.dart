import 'package:eventown/core/utils/app_strings.dart.dart';

class Validation {
  static String? validateEmpty(String value) {
    if (value.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    }
    return null;
  }

  static String? validateEmail(String email) {
    var emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (!emailRegExp.hasMatch(email)) {
      return AppStrings.pleaseEnterValidEmailAddress;
    }
    return null;
  }

  static String? validatePhneNumber(String phone) {
    // var phoneRegExp = RegExp(r'^\+20\d{10}$');
    if (phone.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (phone.trim().length != 10) {
      return AppStrings.pleaseEnterValidPhoneNumber;
    }
    return null;
  }

  static String? validatePassword(String password) {
    var passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (password.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (!passwordRegExp.hasMatch(password)) {
      return AppStrings.pleaseEnterValidPassword;
    }
    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (password != confirmPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateWebsite(String website) {
    var urlRegExp = RegExp(
      r"^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+\/?$",
    );
    if (website.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (!urlRegExp.hasMatch(website)) {
      return AppStrings.pleaseEnterValidWebsite;
    }
    return null;
  }

  static String? validateDouble(String value) {
    if (value.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    }
    if (double.tryParse(value) == null) {
      return AppStrings.pleaseEnterValidPrice;
    }
    return null;
  }
}

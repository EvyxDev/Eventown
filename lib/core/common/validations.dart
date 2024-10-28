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

  static String? validateLink(String link) {
    var linkRegExp = RegExp(
      r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$",
    );
    if (link.trim().isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (!linkRegExp.hasMatch(link)) {
      return AppStrings.pleaseEnterValidLink;
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

//   static validateLength(
//       String value, String textField, int minLength, int maxLength) {
//     if (minLength != 0 && validateEmpty(value, textField) != null) {
//       return validateEmpty(value, textField);
//     } else if (value.length < minLength || value.length > maxLength) {
//       return "$textField ${"must_be_between".localize()} $minLength ${"and".localize()} $maxLength ${"characters".localize()}";
//     }
//     return null;
//   }

//   static validateNumberLength(
//     String value,
//     String textField,
//     int minLength,
//     int maxLength, [
//     bool changeErrorMsg = false,
//   ]) {
//     if (minLength != 0 && validateEmpty(value, textField) != null) {
//       return validateEmpty(value, textField);
//     } else if (value.length < minLength || value.length > maxLength) {
//       String errorMsg = '';
//       if (changeErrorMsg == false) {
//         errorMsg =
//             "$textField ${"must_be_between".localize()} $minLength ${"and".localize()} $maxLength ${"characters".localize()}";
//       } else {
//         errorMsg =
//             '${'max'.localize()} $maxLength ${maxLength > 1 ? 'numbers'.localize() : 'numbers'.localize()}';
//       }
//       if (value.contains('.')) {
//         if (value.split('.').first.length < minLength ||
//             value.split('.').first.length > maxLength) {
//           return errorMsg;
//         } else {
//           return null;
//         }
//       } else {
//         return errorMsg;
//       }
//     }
//     return null;
//   }

//   static validatePhone(String phone) {
//     if (phone.trim().isEmpty) {
//       return 'phone_field_is_required'.localize();
//     } else if (phone.length < 8 || phone.length > 14) {
//       return 'phone_error'.localize();
//     }
//     return null;
//   }

//   static bool matchPasswords(String password, String passwordConfirmation) {
//     return password == passwordConfirmation;
//   }

//   static validateMatchPasswords(
//     String password,
//     String passwordConfirmation, [
//     String? textField,
//   ]) {
//     if (password != passwordConfirmation) {
//       return textField ?? 'passwords_not_match'.localize();
//     }
//     return null;
//   }
}

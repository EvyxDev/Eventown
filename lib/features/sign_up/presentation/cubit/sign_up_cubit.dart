import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/sign_up/data/repositories/sign_up_repo.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo repo;
  SignUpCubit(this.repo) : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);

  //! Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //! Text Editing Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //! Update Governorate
  String? cityController;
  updateCity(String city) {
    cityController = city;
    emit(SignUpInitial());
  }

  //! Update Gender
  String? genderController;
  updateGender(String gender) {
    genderController = gender;
    emit(SignUpInitial());
  }

  //! Password Suffix Icon
  bool isPasswordObscure = true;
  passwordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(SignUpInitial());
  }

  //! Confirm Password Suffix Icon
  bool isConfPasswordObscure = true;
  confPasswordObscure() {
    isConfPasswordObscure = !isConfPasswordObscure;
    emit(SignUpInitial());
  }

  //! Agree to terms
  bool agreedToTerms = false;
  updateAgreedToTerms() {
    agreedToTerms = !agreedToTerms;
    emit(SignUpInitial());
  }

  //! Interests
  List<String> interests = [];
  updateInterest(BuildContext context, String interestId) {
    if (interests.contains(interestId)) {
      interests.remove(interestId);
    } else {
      if (interests.length >= 5) {
        showTwist(
          context: context,
          messege: AppStrings.youCantSelectMoreThan5Interests.tr(context),
          state: ToastStates.success,
        );
      } else {
        interests.add(interestId);
      }
    }
    emit(SignUpInitial());
  }

  //! Check if category is selected
  bool isCategorySelected(String id) {
    return interests.contains(id);
  }

  //! Get All Categories
  List<Category> allCategories = [];
  getAllCategories() async {
    emit(GetAllCategoriesLoading());
    final response = await repo.getAllCategories();
    response.fold(
      (l) {
        emit(GetAllCategoriesFailed(l));
      },
      (r) {
        allCategories = r.data ?? [];
        emit(GetAllCategoriesSuccess());
      },
    );
  }

  //!Sign up
  signUp() async {
    emit(SignUpLoading());
    final response = await repo.signUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confPasswordController.text.trim(),
      location: cityController ?? "Cairo",
      gender: genderController ?? "male",
      phone: '+20${phoneController.text.trim()}',
      interests: interests,
    );
    response.fold(
      (error) {
        emit(SignUpFailed(error));
      },
      (r) {
        sl<CacheHelper>()
            .saveData(key: 'SignUpEmail', value: emailController.text.trim());
        emit(SignUpSuccess());
      },
    );
  }


  //! OTP text editing controller
  OtpFieldController otpController = OtpFieldController();
  String otp = '';
  updateOtp(String otp) {
    this.otp = otp;
    printYellow(otp);
    emit(SignUpInitial());
  }

  submitOtp() async {
    emit(OtpLoading());
    final response = await repo.verifyOtp(otp: otp);
    response.fold(
      (error) {
        printRed(error);
        emit(OtpFailed(error));
      },
      (r) {
        emit(OtpSuccess());
      },
    );
  }

  reSendCode() async {
    emit(ResendCodeLoading());
    final response = await repo.resendCode(
        email: sl<CacheHelper>().getData(key: 'SignUpEmail'));
    response.fold(
      (error) {
        printRed(error);
        emit(ResendCodeFailed(error));
      },
      (r) {
        emit(ResendCodeSuccess());
      },
    );
  }
}
// 2144.83

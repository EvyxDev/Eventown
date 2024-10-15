import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/features/forgot_password/data/repositories/forgot_password_repo.dart';
import 'package:eventown/features/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo repo;

  ForgotPasswordCubit(this.repo) : super(ForgotPasswordInitial());
  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  //!Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  //!Email Controller
  final TextEditingController emailController = TextEditingController();
  getEmail(oldEMail) {
    printRed(oldEMail);
    emailController.text = oldEMail;
  }

  //! Password Suffix Icon
  bool isPasswordObscure = true;
  passwordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(ForgotPasswordInitial());
  }

  //! Confirm Password Suffix Icon
  bool isConfPasswordObscure = true;
  confPasswordObscure() {
    isConfPasswordObscure = !isConfPasswordObscure;
    emit(ForgotPasswordInitial());
  }

  //!Send OTP
  void sendOtp() async {
    emit(ForgotPasswordLoading());
    final response =
        await repo.sendPasswordResetEmail(emailController.text.trim());
    response.fold(
      (l) {
        emit(ForgotPasswordFailed(l));
      },
      (r) {
        sl<CacheHelper>()
            .saveData(key: "forgotEmail", value: emailController.text.trim());
        emit(ForgotPasswordSuccess());
      },
    );
  }

  //! verifyResetCode
  String otp = '';

  updateOtp(String value) {
    otp = value;
    emit(ForgotPasswordInitial());
  }

  void verifyResetCode() async {
    emit(OtpForgotPasswordLoading());
    final response = await repo.verifyResetCode(otp.trim());
    response.fold(
      (l) {
        emit(OtpForgotPasswordFailed(l));
      },
      (r) {
        emit(OtpForgotPasswordSuccess(emailController.text.trim()));
      },
    );
  }

  //!Change Password
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  resetPassword() async {
    emit(ResetPasswordLoading());
    final response = await repo.resetPassword(
      sl<CacheHelper>().getData(key: "forgotEmail"),
      newPasswordController.text.trim(),
    );
    response.fold(
      (l) {
        emit(ResetPasswordFailed(l));
      },
      (r) {
        emit(ResetPasswordSuccess());
      },
    );
  }
}

import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:eventown/features/sign_in/presentation/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo repo;
  SignInCubit(this.repo) : super(SignInInitial());
  static SignInCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
//! Password Suffix Icon
  bool isPasswordObscure = true;
  passwordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(SignInInitial());
  }

  signIn() async {
    emit(SignInLoading());
    final response =
        await repo.signIn(emailController.text, passwordController.text);
    response.fold(
      (l) {
        printRed(l);
        emit(SignInFailed(l));
      },
      (r) {
        sl<CacheHelper>().saveData(key: AppConstants.token, value: r.token);
        printGreen("Welcome ${r.data!.name ?? ""}");
        emit(SignInSuccess());
      },
    );
  }
}

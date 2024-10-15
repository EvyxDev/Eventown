import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/features/sign_up/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/sign_up/data/repositories/sign_up_repo.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo repo;
  SignUpCubit(this.repo) : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? cityController;
  updateCity(String city) {
    cityController = city;
    emit(SignUpInitial());
  }

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

  bool agreedToTerms = false;
  updateAgreedToTerms() {
    agreedToTerms = !agreedToTerms;
    emit(SignUpInitial());
  }

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

  bool isCategorySelected(String id) {
    return interests.contains(id);
  }

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
  signUp() {
    printGreen('signUp');
  }

  List<String> egyptGovernorates = [
    'cairo',
    'giza',
    'alexandria',
    'aswan',
    'asyut',
    'beheira',
    'beniSuef',
    'dakahlia',
    'damietta',
    'faiyum',
    'gharbia',
    'ismailia',
    'kafrElSheikh',
    'luxor',
    'matruh',
    'minya',
    'monufia',
    'newValley',
    'northSinai',
    'portSaid',
    'qalyubia',
    'qena',
    'redSea',
    'sharqia',
    'sohag',
    'southSinai',
    'suez'
  ];
}

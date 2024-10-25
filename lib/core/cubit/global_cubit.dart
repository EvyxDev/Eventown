import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/features/home/presentation/screens/home_screen.dart';
import 'package:eventown/features/settings/data/models/user/user.dart';
import 'package:eventown/features/settings/presentation/screens/settings_screen.dart';
import 'package:eventown/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:eventown/features/wheel/presentation/screens/wheel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../databases/cache/cache_helper.dart';
import '../services/service_locator.dart';
import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final SignInRepo signInRepo;
  GlobalCubit(this.signInRepo) : super(GlobalInitial());
  static GlobalCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const HomeScreen(),
    const WheelScreen(),
    const Scaffold(),
    const SettingsScreen()
  ];

  //! Get Governorates
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

  void changeBottom(int index) {
    currentIndex = index;
    emit(GlobalInitial());
  }

//! on Boarding
  final PageController pageController = PageController();
  int currentOnBoardingIndex = 0;
  updateCurrentIndex(int index) {
    currentOnBoardingIndex = index;
    emit(CurrentIndexUpdated());
  }

  //! Language
  String language = sl<CacheHelper>().getCachedLanguage();
  changeLanguage() {
    printRed("Change Lang");
    sl<CacheHelper>().getCachedLanguage() == "en"
        ? sl<CacheHelper>().cacheLanguage("ar")
        : sl<CacheHelper>().cacheLanguage("en");
    language = sl<CacheHelper>().getCachedLanguage();
    emit(GlobalInitial());
  }

  //! Get User Profile
  UserModel? user;
  getUserProfile({bool? isTryAgain}) async {
    if (isTryAgain == true) emit(GlobalLoading());
    if (sl<CacheHelper>().getData(key: AppConstants.token) != null) {
      final response = await signInRepo.getUserProfile();
      response.fold(
        (fail) {
          emit(FaildToGetProfile());
        },
        (model) {
          user = model;
          emit(GlobalInitial());
        },
      );
    }
  }
}

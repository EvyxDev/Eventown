import 'package:eventown/core/common/logs.dart';
import 'package:eventown/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../databases/cache/cache_helper.dart';
import '../services/service_locator.dart';
import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
  static GlobalCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    // HomeScreen(),
    // WheelScreen(),
    // NotificationScreen(),
    // ProfileScreen(),
    const HomeScreen(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold()
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
}

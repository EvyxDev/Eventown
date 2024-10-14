import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  static List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: Assets.assetsImagesPngOnBoardingOne,
      title: AppStrings.onBoardingTitle1,
      subTitle: AppStrings.onBoardingSubTitle1,
    ),
    OnBoardingModel(
      image: Assets.assetsImagesPngOnBoardingTwo,
      title: AppStrings.onBoardingTitle2,
      subTitle: AppStrings.onBoardingSubTitle2,
    ),
    OnBoardingModel(
      image: Assets.assetsImagesPngOnBoardingThree,
      title: AppStrings.onBoardingTitle3,
      subTitle: AppStrings.onBoardingSubTitle3,
    ),
  ];
}

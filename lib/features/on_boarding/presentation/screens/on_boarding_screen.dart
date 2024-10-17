import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              context.read<GlobalCubit>().currentOnBoardingIndex == 0
                  ? AppColors.black
                  : AppColors.primary,
          body: PageView.builder(
            controller: context.read<GlobalCubit>().pageController,
            onPageChanged: (index) {
              context.read<GlobalCubit>().updateCurrentIndex(index);
            },
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: OnBoardingModel.onBoardingList.length,
            itemBuilder: (context, index) {
              return index == 0
                  //! UI for OnBoarding 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 64.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.onBoardingTitle1.tr(context),
                                    style: CustomTextStyle.roboto400sized14Grey,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 64.h),
                          Image.asset(
                            OnBoardingModel.onBoardingList[index].image,
                            height: 300.h,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            AppStrings.appName.tr(context),
                            style: CustomTextStyle.roboto700sized30White,
                          ),
                          SizedBox(height: 64.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.onBoardingTitle1.tr(context),
                                style: CustomTextStyle.roboto400sized14Grey,
                              ),
                              Text(
                                AppStrings.onBoardingSubTitle1.tr(context),
                                style: CustomTextStyle.roboto500sized16White,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<GlobalCubit>()
                                  .pageController
                                  .nextPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeIn,
                                  );
                            },
                            child: Container(
                              width: 250.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grey,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    AppStrings.seeAllFeatures.tr(context),
                                    style:
                                        CustomTextStyle.roboto400sized14White,
                                  ),
                                  SvgPicture.asset(Assets.assetsImagesSvgLine)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    )
                  //! UI for OnBoarding 2 and 3
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 64.h),
                          Image.asset(
                            OnBoardingModel.onBoardingList[index].image,
                            height: 300.h,
                          ),
                          SizedBox(height: 64.h),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                right: -24,
                                child: SvgPicture.asset(
                                  Assets.assetsImagesSvgLinee,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.start,
                                OnBoardingModel.onBoardingList[index].title
                                    .tr(context),
                                style: CustomTextStyle.roboto900sized30White,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (index == 2) {
                                sl<CacheHelper>().saveData(
                                  key: AppConstants.isFirstTime,
                                  value: false,
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.signIn,
                                  (route) => false,
                                );
                              } else {
                                context
                                    .read<GlobalCubit>()
                                    .pageController
                                    .nextPage(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeIn,
                                    );
                              }
                            },
                            child: Container(
                              width: 250.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.white,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    AppStrings.continuee.tr(context),
                                    style:
                                        CustomTextStyle.roboto400sized14White,
                                  ),
                                  SvgPicture.asset(Assets.assetsImagesSvgLine)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}

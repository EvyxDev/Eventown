import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                                    style: CustomTextStyle
                                        .urbanStorm400sized14Grey,
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
                            style: CustomTextStyle.urbanStorm700sized30White,
                          ),
                          SizedBox(height: 64.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.onBoardingTitle1.tr(context),
                                style: CustomTextStyle.urbanStorm400sized14Grey,
                              ),
                              Text(
                                AppStrings.onBoardingSubTitle1.tr(context),
                                style:
                                    CustomTextStyle.urbanStorm500sized16White,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            // onTap: () {
                            //   context.read<GlobalCubit>().pageController.nextPage(
                            //         duration: const Duration(milliseconds: 500),
                            //         curve: Curves.easeIn,
                            //       );
                            // },
                            onTap: () => sl<GlobalCubit>().changeLanguage(),
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
                                    style: CustomTextStyle
                                        .urbanStorm400sized14White,
                                  ),
                                  const Icon(Icons.arrow_forward)
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 64.h),
                          Image.asset(
                            OnBoardingModel.onBoardingList[index].image,
                            height: 300.h,
                          ),
                          SizedBox(height: 64.h),
                          Text(
                            OnBoardingModel.onBoardingList[index].title
                                .tr(context),
                            style: CustomTextStyle.urbanStorm400sized10White,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            textAlign: TextAlign.center,
                            OnBoardingModel.onBoardingList[index].subTitle
                                .tr(context),
                            style: CustomTextStyle.urbanStorm400sized10White,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 64.h),
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

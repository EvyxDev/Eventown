import 'package:card_swiper/card_swiper.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/categories_in_home_section.dart';
import 'package:eventown/features/home/presentation/widgets/events_section.dart';
import 'package:eventown/features/home/presentation/widgets/home_app_bar.dart';
import 'package:eventown/features/home/presentation/widgets/wheel_promotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: getHomeAppBar(context),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: RefreshIndicator(
                  onRefresh: () async {
                    return context.read<HomeCubit>().getHomeData();
                  },
                  backgroundColor: AppColors.white,
                  child: ListView(
                    children: [
                      SizedBox(height: 16.h),
                      //! Home Categories
                      context.read<HomeCubit>().homeCategories.isNotEmpty
                          ? Column(
                              children: [
                                CategoriesInHomeSection(
                                  homeCategories:
                                      context.read<HomeCubit>().homeCategories,
                                ),
                                SizedBox(height: 16.h),
                              ],
                            )
                          : const SizedBox.shrink(),

                      context.read<HomeCubit>().topEvents.isEmpty &&
                              context.read<HomeCubit>().forYouEvents.isEmpty &&
                              context
                                  .read<HomeCubit>()
                                  .inYourAreaEvents
                                  .isEmpty &&
                              context
                                  .read<HomeCubit>()
                                  .onThisWeekEvents
                                  .isEmpty &&
                              state is! HomeLoading
                          ? RefreshIndicator(
                              onRefresh: () async {
                                context.read<HomeCubit>().getHomeData();
                              },
                              backgroundColor: AppColors.white,
                              child: SizedBox(
                                height: 200.h,
                                child: ListView(
                                  children: [
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      child: Center(
                                        child: Text(
                                          AppStrings.noEventsFound.tr(context),
                                          style: CustomTextStyle
                                              .roboto700sized20White,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                //! Top Events
                                Column(
                                  children: [
                                    EventsSection(
                                      title: AppStrings.topEvents.tr(context),
                                      eventsType: EventsType.topEvents,
                                      events:
                                          context.read<HomeCubit>().topEvents,
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),

                                SizedBox(height: 16.h),
                                //! Game Promotion Section
                                Container(
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Swiper(
                                    loop: true,
                                    autoplay: true,
                                    duration: const Duration(milliseconds: 2000)
                                        .inMilliseconds,
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: WheelPromotion(index: index),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                //! On This Week Events
                                Column(
                                  children: [
                                    EventsSection(
                                      title: AppStrings.onThisWeekEvents
                                          .tr(context),
                                      eventsType: EventsType.onThisWeek,
                                      width: 200.w,
                                      events: context
                                          .read<HomeCubit>()
                                          .onThisWeekEvents,
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),

                                //! For You Events
                                Column(
                                  children: [
                                    EventsSection(
                                      title:
                                          AppStrings.forYouEvents.tr(context),
                                      eventsType: EventsType.forYou,
                                      width: 200.w,
                                      events: context
                                          .read<HomeCubit>()
                                          .forYouEvents,
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),
                                //! In Your Area Events
                                Column(
                                  children: [
                                    EventsSection(
                                      title: AppStrings.inYourAreaEvents
                                          .tr(context),
                                      eventsType: EventsType.inYourArea,
                                      width: 200.w,
                                      events: context
                                          .read<HomeCubit>()
                                          .inYourAreaEvents,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

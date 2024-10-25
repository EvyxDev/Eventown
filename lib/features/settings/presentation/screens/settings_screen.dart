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
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/screens/view_all_screen.dart';
import 'package:eventown/features/profile/data/repositories/profile_repo.dart';
import 'package:eventown/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:eventown/features/profile/presentation/screens/profile_screen.dart';
import 'package:eventown/features/settings/presentation/screens/calender_screen.dart';
import 'package:eventown/features/settings/presentation/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final cubit = context.read<GlobalCubit>();
          return state is GlobalLoading
              ? const Center(
                  child: CustomLoadingIndicator(),
                )
              : GlobalCubit.get(context).user == null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.canNotGetUserData.tr(context),
                              style: CustomTextStyle.roboto700sized20White,
                            ),
                            SizedBox(height: 16.h),
                            CustomElevatedButton(
                              text: AppStrings.tryAgain.tr(context),
                              onPressed: () {
                                cubit.getUserProfile(isTryAgain: true);
                              },
                            ),
                            SizedBox(height: 16.h),
                            CustomElevatedButton(
                              text: AppStrings.logout.tr(context),
                              color: AppColors.black,
                              onPressed: () {
                                sl<CacheHelper>().clearData();
                                sl<CacheHelper>().saveData(
                                  key: AppConstants.isFirstTime,
                                  value: false,
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.signIn,
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        ProfileCubit(sl<ProfileRepo>())
                                          ..initControllers(
                                            cubit.user?.data?.name ?? "",
                                            (cubit.user?.data?.phone
                                                    ?.replaceAll("+20", "")) ??
                                                "",
                                            cubit.user?.data?.location,
                                            cubit.user?.data?.gender,
                                          ),
                                    child: const ProfileScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 48.h,
                              left: 16.w,
                              right: 16.w,
                              bottom: 16.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary,
                                  Colors.deepOrange.shade800,
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r),
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 32.r,
                                  backgroundImage: context
                                              .read<GlobalCubit>()
                                              .user
                                              ?.data
                                              ?.profileImg !=
                                          null
                                      ? displayProviderCachedNetworkImage(
                                          imageUrl:
                                              cubit.user?.data?.profileImg ??
                                                  "")
                                      : const AssetImage(
                                          Assets.assetsImagesPngProfile,
                                        ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.user?.data?.name ?? '',
                                        style: CustomTextStyle
                                            .roboto700sized20White,
                                      ),
                                      Text(
                                        cubit.user?.data?.email ?? "",
                                        style: CustomTextStyle
                                            .roboto400sized14White,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) =>
                                                ProfileCubit(sl<ProfileRepo>())
                                                  ..initControllers(
                                                    cubit.user?.data?.name ??
                                                        "",
                                                    (cubit.user?.data?.phone
                                                            ?.replaceAll(
                                                                "+20", "")) ??
                                                        "",
                                                    cubit.user?.data?.location,
                                                    cubit.user?.data?.gender,
                                                  ),
                                            child: const ProfileScreen(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: AppColors.white,
                                    size: 24.r,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            AppStrings.settings.tr(context),
                            style: CustomTextStyle.roboto700sized20White,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SettingsItem(
                                  title: AppStrings.myCalendar.tr(context),
                                  icon: Icons.calendar_month_outlined,
                                  onTap: () {
                                    context.read<HomeCubit>().getUserCalender();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const CalenderScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SettingsItem(
                                  title: AppStrings.interstedEvents.tr(context),
                                  icon: Icons.turned_in_outlined,
                                  onTap: () {
                                    context.read<HomeCubit>().getViewAllEvents(
                                        type: EventsType.forYou);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ViewAllScreen(
                                            eventsType: EventsType.forYou,
                                            title: AppStrings.interstedEvents
                                                .tr(context),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SettingsItem(
                                  title: AppStrings.cityAndArea.tr(context),
                                  icon: Icons.location_on,
                                  onTap: () {
                                    context.read<HomeCubit>().getViewAllEvents(
                                        type: EventsType.inYourArea);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ViewAllScreen(
                                            eventsType: EventsType.inYourArea,
                                            title: AppStrings.inYourAreaEvents
                                                .tr(context),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SettingsItem(
                                  title: AppStrings.createEvents.tr(context),
                                  icon: Icons.add_box_rounded,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title: AppStrings.iAmOrganizer.tr(context),
                                  icon: Icons.people,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title: AppStrings.language.tr(context),
                                  icon: Icons.language,
                                  onTap: () {
                                    cubit.changeLanguage();
                                  },
                                ),
                                SettingsItem(
                                  title: AppStrings.shareApp.tr(context),
                                  icon: Icons.share,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title: AppStrings.sendFeedback.tr(context),
                                  icon: Icons.feedback,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title: AppStrings.needAHelp.tr(context),
                                  icon: Icons.help,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title: AppStrings.deleteMyAccount.tr(context),
                                  icon: Icons.delete_forever,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title:
                                      AppStrings.termsAndConditions.tr(context),
                                  icon: Icons.note_rounded,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.termsAndConditions,
                                    );
                                  },
                                ),
                                SettingsItem(
                                  title: AppStrings.privacyPolicy.tr(context),
                                  icon: Icons.privacy_tip_rounded,
                                  onTap: () {},
                                ),
                                SettingsItem(
                                  title: AppStrings.logout.tr(context),
                                  icon: Icons.logout_rounded,
                                  onTap: () {
                                    // sl<CacheHelper>().clearData();
                                    // sl<CacheHelper>().saveData(
                                    //   key: AppConstants.isFirstTime,
                                    //   value: false,
                                    // );
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //   context,
                                    //   Routes.signIn,
                                    //   (route) => false,
                                    // );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}

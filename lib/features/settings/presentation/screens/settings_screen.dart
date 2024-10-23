import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 28.h),
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
                      radius: 38.r,
                      backgroundImage: const AssetImage(
                        Assets.assetsImagesPngProfile,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: CustomTextStyle.roboto700sized20White,
                          ),
                          Text(
                            'happytech.mohammedsaeed@gmail.com',
                            style: CustomTextStyle.roboto400sized14White,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_outlined,
                        color: AppColors.white,
                        size: 24.r,
                      ),
                    )
                  ],
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
                        onTap: () {},
                      ),
                      SettingsItem(
                        title: AppStrings.interstedEvents.tr(context),
                        icon: Icons.turned_in_outlined,
                        onTap: () {},
                      ),
                      SettingsItem(
                        title: AppStrings.cityAndArea.tr(context),
                        icon: Icons.location_on,
                        onTap: () {},
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
                          context.read<GlobalCubit>().changeLanguage();
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
                        title: AppStrings.termsAndConditions.tr(context),
                        icon: Icons.note_rounded,
                        onTap: () {},
                      ),
                      SettingsItem(
                        title: AppStrings.privacyPolicy.tr(context),
                        icon: Icons.privacy_tip_rounded,
                        onTap: () {},
                      ),
                      SettingsItem(
                        title: AppStrings.logout.tr(context),
                        icon: Icons.logout_rounded,
                        onTap: () {},
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

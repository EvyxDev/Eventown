import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/settings/presentation/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                style: CustomTextStyle.roboto700sized14Grey,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_outlined,
                            color: AppColors.primary,
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
                      'Settings',
                      style: CustomTextStyle.roboto700sized20White,
                    ),
                  ),
                  SettingsItem(
                    title: 'My Calendar',
                    icon: Icons.calendar_month_outlined,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Intersted Events',
                    icon: Icons.turned_in_outlined,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'City and Area',
                    icon: Icons.location_on,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Create Events',
                    icon: Icons.add_box_rounded,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'I Am Organizer',
                    icon: Icons.people,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Language',
                    icon: Icons.language,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Share App',
                    icon: Icons.share,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Send Feedback',
                    icon: Icons.feedback,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Need A Help',
                    icon: Icons.help,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Delete My Account',
                    icon: Icons.delete_forever,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Terms And Conditions',
                    icon: Icons.note_rounded,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Privacy Policy',
                    icon: Icons.privacy_tip_rounded,
                    onTap: () {},
                  ),
                  SettingsItem(
                    title: 'Logout',
                    icon: Icons.logout_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

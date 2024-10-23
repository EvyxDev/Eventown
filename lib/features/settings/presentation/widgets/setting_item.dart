import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: CustomTextStyle.roboto500sized16Grey,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.r,
      ),
      onTap: onTap,
      leading: Icon(
        icon,
        size: 24.r,
        color: AppColors.primary,
      ),
    );
  }
}

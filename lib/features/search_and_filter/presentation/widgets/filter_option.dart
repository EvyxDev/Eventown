import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterOption extends StatelessWidget {
  const FilterOption({
    super.key,
    required this.label,
    required this.onTap,
  });
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.close,
              color: AppColors.white,
              size: 18.r,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: CustomTextStyle.roboto500sized12White,
          ),
        ],
      ),
    );
  }
}

import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesInHomeSection extends StatelessWidget {
  const CategoriesInHomeSection({super.key, required this.homeCategories});
  final List<Category> homeCategories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: homeCategories.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              homeCategories[index].title ?? '',
              style: CustomTextStyle.roboto500sized14White,
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
      ),
    );
  }
}

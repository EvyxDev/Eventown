import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

AppBar getHomeAppBar(BuildContext context) {
  return AppBar(
    leadingWidth: 170.w,
    actions: [
      TextButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) {
          //     return WelcomeOrganizerScreen();
          //   },
          // ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                const Icon(
                  IconlyBold.plus,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                Text(
                  AppStrings.createEvent.tr(context),
                  style: CustomTextStyle.roboto400sized14White,
                ),
              ],
            ),
          ),
        ),
      )
    ],
    leading: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.assetsImagesSvgIconPlaceholder,
            width: 36.w,
            height: 36.h,
          ),
          SizedBox(width: 8.w),
          Text(
            AppStrings.appName.tr(context),
            style: CustomTextStyle.roboto700sized20White,
          ),
        ],
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            Colors.deepOrange.shade800,
          ],
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 8.w),
            Expanded(
              child: CustomTextFormField(
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                borderColor: AppColors.white,
                borderRadius: 8.r,
                style: CustomTextStyle.roboto700sized12Grey,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey,
                ),
                hintText: AppStrings.search.tr(context),
                hintStyle: CustomTextStyle.roboto700sized12Grey,
                onFieldSubmitted: (value) {
                  // context
                  //     .read<HomeBloc>()
                  //     .add(SearchEvents(keyword: value));
                },
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: InkWell(
                onTap: () {
                  // _onFilterIconPressed(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
                  child: SvgPicture.asset(
                    Assets.assetsImagesSvgFilter,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    ),
  );
}

import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: CustomTextStyle.roboto700sized20White,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 64.h),
              Image.asset(
                Assets.assetsImagesPngCheck,
                width: 200.w,
                height: 200.h,
              ),
              SizedBox(height: 64.h),
              Text(
                subTitle,
                style: CustomTextStyle.roboto500sized14White,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

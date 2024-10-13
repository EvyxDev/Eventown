import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jumping_dot/jumping_dot.dart';
import '../utils/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.height,
  });
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      child: JumpingDots(
        color: AppColors.primary,
        numberOfDots: 4,
      ),
    );
  }
}

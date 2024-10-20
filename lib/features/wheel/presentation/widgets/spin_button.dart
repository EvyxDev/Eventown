import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

Widget spinButton(Duration remainingTime, BehaviorSubject<int> selected,
    List<int> items, BuildContext context) {
  final formattedTime = formatDuration(remainingTime);
  return GestureDetector(
    onTap: remainingTime <= Duration.zero
        ? () => selected.add(Fortune.randomInt(0, items.length))
        : null,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: (remainingTime <= Duration.zero
              ? AppColors.primary
              : Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        remainingTime <= Duration.zero
            ? AppStrings.spin.tr(context)
            : "${AppStrings.spin.tr(context)} $formattedTime",
        style: CustomTextStyle.roboto500sized14White,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCardGame extends StatelessWidget {
  final String title;
  final String content;
  final String userName;
  final String eventName;
  final String timeAgo;

  const ReviewCardGame({
    super.key,
    required this.title,
    required this.content,
    required this.userName,
    required this.timeAgo,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.assetsImagesPngProfile,
                  width: 42.w,
                ),
                SizedBox(width: 8.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: CustomTextStyle.roboto500sized14Primary,
                    ),
                    Text(
                      eventName,
                      style: CustomTextStyle.roboto400sized12Secoundry,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              content,
              style: CustomTextStyle.roboto400sized14Grey,
              maxLines: 3,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  timeAgo,
                  style: CustomTextStyle.roboto400sized14Grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCardGame extends StatelessWidget {
  final String title;
  final String content;
  final String userName;
  final String? userImage;
  final String? img;
  final String timeAgo;

  const ReviewCardGame({
    super.key,
    this.userImage,
    this.img,
    required this.title,
    required this.content,
    required this.userName,
    required this.timeAgo,
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
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: userImage == null
                          ? const AssetImage(
                              Assets.assetsImagesPngProfile,
                            )
                          : displayProviderCachedNetworkImage(
                              imageUrl: userImage!,
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    userName,
                    style: CustomTextStyle.roboto500sized14Primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            img != null
                ? Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image:
                            displayProviderCachedNetworkImage(imageUrl: img!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: 16.h),
            Text(
              content,
              style: CustomTextStyle.roboto400sized14Grey,
              maxLines: 3,
              textAlign: TextAlign.start,
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

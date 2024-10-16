import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  // final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: displayProviderCachedNetworkImage(
              imageUrl:
                  'https://media.licdn.com/dms/image/v2/C4D1BAQFAC3o2eHS_vA/company-background_10000/company-background_10000/0/1583354651497/gl_events_cover?e=2147483647&v=beta&t=vYbDxX-8NtFbXXygSIhuJHveB3fzVMLW9BEQJWOf-yU'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 8.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "25/10/2024",
                    style: CustomTextStyle.roboto400sized14White,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    IconlyLight.heart,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 60.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(IconlyBold.bookmark, size: 16),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              "HappyTech",
                              style: CustomTextStyle.roboto500sized16White,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(IconlyBold.location, size: 16),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              "Nasr City",
                              style: CustomTextStyle.roboto400sized14White,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            IconlyBold.time_circle,
                            size: 16,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              "12:20 PM",
                              style: CustomTextStyle.roboto400sized14White,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.people,
                            size: 16,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              '${"5"} Going',
                              style: CustomTextStyle.roboto400sized14White,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/presentation/screens/event_screen_details.dart';
import 'package:eventown/features/home/presentation/widgets/wishlist_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EventScreenDetails(eventId: event.id ?? "");
            },
          ),
        );
      },
      child: Container(
        width: 280.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: event.eventImage != null
                            ? displayProviderCachedNetworkImage(
                                imageUrl: event.eventImage!)
                            : const AssetImage(
                                Assets.assetsImagesPngEventPlaceHolder,
                              ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
                            "${event.eventPrice} ${AppStrings.egp.tr(context)}",
                            style: CustomTextStyle.roboto400sized14White,
                          ),
                        ),
                        WishlistBtn(
                          event: event,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 75.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
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
                                        event.eventName ?? "Unknown",
                                        style: CustomTextStyle
                                            .roboto500sized16White,
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
                                        event.eventAddress ?? "Unknown",
                                        style: CustomTextStyle
                                            .roboto400sized14White,
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
                                        convertTime(
                                            event.eventStartTime),
                                        style: CustomTextStyle
                                            .roboto400sized14White,
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
                                        '${event.numberOfGoingUsers ?? 0} ${AppStrings.going.tr(context)}',
                                        style: CustomTextStyle
                                            .roboto400sized14White,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -25.h,
                  left: 16.w,
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      child: Text(
                        formatDate(
                          event.eventDate.toString(),
                        ),
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.roboto500sized14Black,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

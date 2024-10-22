import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventScreenDetails extends StatelessWidget {
  const EventScreenDetails({
    super.key,
    required this.eventModel,
  });
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            eventModel.eventImage == null
                ? Image.asset(
                    Assets.assetsImagesPngEventPlaceHolder,
                    height: 250.h,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  )
                : displayCachedNetworkImage(
                    imageUrl: eventModel.eventImage ?? '',
                    height: 250.h,
                    fit: BoxFit.fill,
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  // Event Title
                  Text(
                    eventModel.eventName ?? '',
                    style: CustomTextStyle.roboto700sized20White,
                    overflow: TextOverflow.fade,
                  ),
                  SizedBox(height: 16.h),
                  // Event Description
                  Text(
                    eventModel.eventDescription ?? '',
                    style: CustomTextStyle.roboto400sized14Grey,
                    overflow: TextOverflow.fade,
                  ),
                  SizedBox(height: 16.h),
                  // Event Organizer
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          eventModel.organizerName ?? '',
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Price
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          "${eventModel.eventPrice} ${AppStrings.egp.tr(context)}",
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Contact
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          eventModel.organizationPhoneNumber ?? '',
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          eventModel.eventLocation ?? '',
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          displayDate(eventModel.eventDate) ?? "",
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Time
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          "${convertTime(eventModel.eventStartTime.toString())} - ${convertTime(eventModel.eventEndTime.toString())}",
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Category
                  Row(
                    children: [
                      const Icon(
                        Icons.tag,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          (eventModel.eventCategory ?? [])
                              .map((e) => e.title)
                              .join(', '),
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Event Website
                  Row(
                    children: [
                      const Icon(
                        Icons.web,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          eventModel.organizationWebsite ?? '',
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Event Ticket Link
                  Row(
                    children: [
                      const Icon(
                        Icons.link,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          eventModel.ticketEventLink ?? '',
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Event Social Media
                  Row(
                    children: [
                      const Icon(
                        Icons.share,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          eventModel.organizationEmail ?? '',
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // //comments
                  // if (eventModel.comments != null)
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "comments".tr(context),
                  //         style: CustomTextStyle.roboto700sized20White,
                  //         overflow: TextOverflow.fade,
                  //       ),
                  //       SizedBox(height: 16.h),
                  //       ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemCount: eventModel.comments!.length,
                  //         itemBuilder: (context, index) {
                  //           return Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 eventModel.comments![index].text ?? '',
                  //                 style: CustomTextStyle.roboto400sized14Grey,
                  //                 overflow: TextOverflow.fade,
                  //               ),
                  //               SizedBox(height: 16.h),
                  //             ],
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

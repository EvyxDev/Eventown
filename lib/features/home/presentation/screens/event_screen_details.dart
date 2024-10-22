import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
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
                          imageUrl: eventModel.eventImage ?? '-',
                          height: 250.h,
                          fit: BoxFit.fill,
                        ),
                  Positioned(
                    bottom: -25,
                    left: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: Text(
                        "${eventModel.eventPrice} ${AppStrings.egp.tr(context)}",
                        style: CustomTextStyle.roboto400sized14White.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    // Event Title
                    Text(
                      eventModel.eventName ?? '-',
                      style: CustomTextStyle.roboto700sized20White,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(height: 16.h),
                    // Event Description
                    Text(
                      eventModel.eventDescription ?? '-',
                      style: CustomTextStyle.roboto400sized14Grey,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      // Event Organizer
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              eventModel.organizerName ?? '-',
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        // Event Contact
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.phone,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              eventModel.organizationPhoneNumber ?? '-',
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        // Event Location
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              eventModel.eventLocation ?? '-',
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        // Event Date
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              displayDate(eventModel.eventDate) ?? "",
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        // Event Time
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "${convertTime(eventModel.eventStartTime.toString())} - ${convertTime(eventModel.eventEndTime.toString())}",
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        // Event Category
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.tag,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
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
                        // Event Website
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.web,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                eventModel.organizationWebsite ?? '-',
                                style: CustomTextStyle.roboto400sized14Grey,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),

                        // Event Ticket Link
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.link,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                eventModel.ticketEventLink ?? '-',
                                style: CustomTextStyle.roboto400sized14Grey,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),

                        // Event Social Media
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.share,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                eventModel.organizationEmail ?? '-',
                                style: CustomTextStyle.roboto400sized14Grey,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: AppStrings.getTicket.tr(context),
                      elevation: 0,
                      onPressed: () {},
                    ),
                    SizedBox(height: 16.h),
                    //comments
                    if (eventModel.comments != null &&
                        eventModel.comments!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.comments.tr(context),
                            style: CustomTextStyle.roboto700sized20White,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(height: 16.h),
                          Column(
                            children: List.generate(
                              eventModel.comments!.length,
                              (index) {
                                return Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 18.r,
                                        backgroundImage: const AssetImage(
                                            Assets.assetsImagesPngProfile)),
                                    SizedBox(width: 16.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          eventModel.comments![index].user!
                                                  .name ??
                                              '-',
                                          style: CustomTextStyle
                                              .roboto400sized14White,
                                          overflow: TextOverflow.fade,
                                        ),
                                        Text(
                                          eventModel.comments![index].text ??
                                              '-',
                                          style: CustomTextStyle
                                              .roboto400sized12Grey,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

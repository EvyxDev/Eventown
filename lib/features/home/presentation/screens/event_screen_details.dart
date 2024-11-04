import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/wishlist_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventScreenDetails extends StatefulWidget {
  const EventScreenDetails({super.key, required this.eventId});
  final String eventId;
  @override
  State<EventScreenDetails> createState() => _EventScreenDetailsState();
}

class _EventScreenDetailsState extends State<EventScreenDetails> {
  @override
  void initState() {
    context.read<HomeCubit>().getEventById(widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is CreateCommentSuccess) {
              showTwist(
                  context: context,
                  messege: AppStrings.commentCreatedSuccessfully.tr(context));
            } else if (state is CreateCommentError) {
              showTwist(
                context: context,
                messege: AppStrings.faildToCreateComment.tr(context),
              );
            }
          },
          builder: (context, state) {
            var event = context.read<HomeCubit>().eventById;
            var cubit = context.read<HomeCubit>();
            return state is GetEventByIdLoading
                ? const Center(child: CustomLoadingIndicator())
                : event == null
                    ? const Center(
                        child: Text("Somthing went wrong"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // Event Image
                                event.eventImage == null
                                    ? Image.asset(
                                        Assets.assetsImagesPngEventPlaceHolder,
                                        height: 250.h,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      )
                                    : displayCachedNetworkImage(
                                        imageUrl: event.eventImage ?? '-',
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
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black
                                                .withOpacity(0.5),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ]),
                                    child: Text(
                                      "${event.eventPrice} ${AppStrings.egp.tr(context)}",
                                      style: CustomTextStyle
                                          .roboto400sized14White
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 25,
                                  right: 16.w,
                                  child: WishlistBtn(
                                    event: event,
                                    size: 24,
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
                                    event.eventName ?? '-',
                                    style:
                                        CustomTextStyle.roboto700sized20White,
                                    overflow: TextOverflow.fade,
                                  ),

                                  SizedBox(height: 16.h),
                                  Wrap(
                                    spacing: 12.w,
                                    runSpacing: 12.h,
                                    // Event Organizer
                                    children: [
                                      // Row(
                                      //   mainAxisSize: MainAxisSize.min,
                                      //   children: [
                                      //     const Icon(
                                      //       Icons.people_alt,
                                      //       color: AppColors.primary,
                                      //     ),
                                      //     SizedBox(width: 4.w),
                                      //     Text(
                                      //       (event.numberOfGoingUsers ?? 0)
                                      //           .toString(),
                                      //       style: CustomTextStyle
                                      //           .roboto400sized14Grey,
                                      //       overflow: TextOverflow.fade,
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: AppColors.primary,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            event.organizerName ?? '-',
                                            style: CustomTextStyle
                                                .roboto400sized14Grey,
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
                                            event.eventAddress ?? '-',
                                            style: CustomTextStyle
                                                .roboto400sized14Grey,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                      // Event Website
                                      InkWell(
                                        onTap: () {
                                          launchCustomUrl(context,
                                              event.organizationWebsite);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.web,
                                              color: AppColors.primary,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              AppStrings.website.tr(context),
                                              style: CustomTextStyle
                                                  .roboto400sized14Grey
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: AppColors.grey,
                                              ),
                                              overflow: TextOverflow.fade,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Event Social Media
                                      InkWell(
                                        onTap: () {
                                          launchEmailClient(
                                              context, event.organizationEmail);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.email,
                                              color: AppColors.primary,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              AppStrings.email.tr(context),
                                              style: CustomTextStyle
                                                  .roboto400sized14Grey
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: AppColors.grey,
                                              ),
                                              overflow: TextOverflow.fade,
                                            ),
                                          ],
                                        ),
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
                                            displayDate(event.eventDate) ?? "",
                                            style: CustomTextStyle
                                                .roboto400sized14Grey,
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
                                          Expanded(
                                            child: Text(
                                              "${AppStrings.startTime.tr(context)} ${displayDateAndTime(event.eventStartTime)}\n${AppStrings.endTime.tr(context)} ${displayDateAndTime(event.eventEndTime)}",
                                              style: CustomTextStyle
                                                  .roboto400sized14Grey,
                                              overflow: TextOverflow.fade,
                                              textDirection: TextDirection.ltr,
                                            ),
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
                                              (event.eventCategory ?? [])
                                                  .map((e) => e.title)
                                                  .join(', '),
                                              style: CustomTextStyle
                                                  .roboto400sized14Grey,
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
                                    onPressed: () {
                                      launchCustomUrl(
                                          context, event.ticketEventLink);
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  AddToCalenderBtn(cubit: cubit, event: event),
                                  SizedBox(height: 16.h),
                                  // Event Description
                                  Text(
                                    event.eventDescription ?? '-',
                                    style: CustomTextStyle.roboto400sized14Grey,
                                    overflow: TextOverflow.fade,
                                  ),
                                  SizedBox(height: 16.h),
                                  //comments
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.comments.tr(context),
                                        style: CustomTextStyle
                                            .roboto700sized20White,
                                        overflow: TextOverflow.fade,
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextFormField(
                                        hintText: AppStrings.writeYourComment
                                            .tr(context),
                                        suffixIcon: InkWell(
                                          onTap: () async {
                                            if (HomeCubit.get(context)
                                                .commentController
                                                .text
                                                .isNotEmpty) {
                                              HomeCubit.get(context)
                                                  .createComment(
                                                      event.id ?? "",
                                                      context
                                                              .read<
                                                                  GlobalCubit>()
                                                              .user
                                                              ?.data
                                                              ?.name ??
                                                          "");
                                              HomeCubit.get(context)
                                                  .commentController
                                                  .clear();
                                            }
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        controller: HomeCubit.get(context)
                                            .commentController,
                                      ),
                                      SizedBox(height: 32.h),
                                      HomeCubit.get(context)
                                              .eventByIdComments
                                              .isEmpty
                                          ? Column(
                                              children: [
                                                Align(
                                                  child: Text(
                                                    AppStrings.noCommentsYet
                                                        .tr(context),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 64.h,
                                                )
                                              ],
                                            )
                                          : Column(
                                              children: List.generate(
                                                HomeCubit.get(context)
                                                    .eventByIdComments
                                                    .length,
                                                (index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 16.h),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 18.r,
                                                          backgroundImage:
                                                              const AssetImage(
                                                            Assets
                                                                .assetsImagesPngProfile,
                                                          ),
                                                        ),
                                                        SizedBox(width: 16.w),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                HomeCubit.get(
                                                                            context)
                                                                        .eventByIdComments[
                                                                            index]
                                                                        .user!
                                                                        .name ??
                                                                    '-',
                                                                style: CustomTextStyle
                                                                    .roboto400sized14White,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade),
                                                            Text(
                                                                HomeCubit.get(
                                                                            context)
                                                                        .eventByIdComments[
                                                                            index]
                                                                        .text ??
                                                                    '-',
                                                                style: CustomTextStyle
                                                                    .roboto400sized12Grey,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                      SizedBox(height: 32.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
          },
        ),
      ),
    );
  }
}

class AddToCalenderBtn extends StatelessWidget {
  const AddToCalenderBtn({
    super.key,
    required this.cubit,
    required this.event,
  });

  final HomeCubit cubit;
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddEventToCalenderFailed) {
          showTwist(
            context: context,
            messege: AppStrings.couldNotAddToCalendar.tr(context),
          );
        } else if (state is RemoveEventFromCalenderFailed) {
          showTwist(
            context: context,
            messege: AppStrings.couldNotRemoveFromCalendar.tr(context),
          );
        } else if (state is AddEventToCalenderSuccess) {
          showTwist(
            context: context,
            messege: AppStrings.addedToCalendar.tr(context),
          );
        } else if (state is RemoveEventFromCalenderSuccess) {
          showTwist(
            context: context,
            messege: AppStrings.removedFromCalendar.tr(context),
          );
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          text: cubit.isEventInCalender(event.id ?? "")
              ? AppStrings.removeFromCalendar.tr(context)
              : AppStrings.addToCalendar.tr(context),
          elevation: 0,
          onPressed: () {
            if (cubit.isEventInCalender(event.id ?? "")) {
              cubit.removeEventFromCalender(event: event);
            } else {
              cubit.addEventToCalender(event: event);
            }
          },
          color: AppColors.black,
        );
      },
    );
  }
}

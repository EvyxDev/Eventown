import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_drop_down_button.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/screens/select_plan_screen.dart';
import 'package:eventown/features/home/presentation/widgets/upload_event_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  late GlobalKey<FormState> createEventFormKey;
  late TextEditingController nameCreateEventController;
  late TextEditingController addressCreateEventController;
  late TextEditingController organizerNameCreateEventController;
  late TextEditingController organizationNameCreateEventController;
  late TextEditingController organizationPhoneNumberCreateEventController;
  late TextEditingController organizationEmailCreateEventController;
  late TextEditingController organizationWebsiteCreateEventController;
  late TextEditingController ticketEventLinkCreateEventController;
  late TextEditingController eventPriceCreateEventController;
  late TextEditingController eventDescriptionCreateEventController;

  @override
  void initState() {
    super.initState();
    createEventFormKey = GlobalKey<FormState>();
    nameCreateEventController = TextEditingController();
    addressCreateEventController = TextEditingController();
    organizerNameCreateEventController = TextEditingController();
    organizationNameCreateEventController = TextEditingController();
    organizationPhoneNumberCreateEventController = TextEditingController();
    organizationEmailCreateEventController = TextEditingController();
    organizationWebsiteCreateEventController = TextEditingController();
    ticketEventLinkCreateEventController = TextEditingController();
    eventPriceCreateEventController = TextEditingController();
    eventDescriptionCreateEventController = TextEditingController();
  }

  @override
  void dispose() {
    nameCreateEventController.dispose();
    addressCreateEventController.dispose();
    organizerNameCreateEventController.dispose();
    organizationNameCreateEventController.dispose();
    organizationPhoneNumberCreateEventController.dispose();
    organizationEmailCreateEventController.dispose();
    organizationWebsiteCreateEventController.dispose();
    ticketEventLinkCreateEventController.dispose();
    eventPriceCreateEventController.dispose();
    eventDescriptionCreateEventController.dispose();
    createEventFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              const CreateEventAppBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: createEventFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          //!! Event Image
                          const UploadEventImage(),
                          //!eventName
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            labelText: AppStrings.eventName.tr(context),
                            controller: nameCreateEventController,
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! eventAddress
                          CustomTextFormField(
                            labelText: AppStrings.eventAddress.tr(context),
                            controller: addressCreateEventController,
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //!organizerName
                          CustomTextFormField(
                            labelText: AppStrings.organizerName.tr(context),
                            controller: organizerNameCreateEventController,
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //!organizationName
                          CustomTextFormField(
                            labelText: AppStrings.organizationName.tr(context),
                            controller: organizationNameCreateEventController,
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! organizationPhoneNumber
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: CustomTextFormField(
                              controller:
                                  organizationPhoneNumberCreateEventController,
                              labelText: AppStrings.organizationPhoneNumber
                                  .tr(context),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                return Validation.validatePhneNumber(value!) !=
                                        null
                                    ? Validation.validatePhneNumber(value)!
                                        .tr(context)
                                    : Validation.validatePhneNumber(value);
                              },
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                child: Text(
                                  "+20",
                                  style: CustomTextStyle.roboto700sized14Grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          //! organizationEmail
                          CustomTextFormField(
                            labelText: AppStrings.organizationEmail.tr(context),
                            controller: organizationEmailCreateEventController,
                            validator: (value) {
                              return Validation.validateEmail(value!) != null
                                  ? Validation.validateEmail(value)!.tr(context)
                                  : Validation.validateEmail(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! organizationWebsite
                          CustomTextFormField(
                            labelText:
                                AppStrings.organizationWebsite.tr(context),
                            controller:
                                organizationWebsiteCreateEventController,
                            validator: (value) {
                              return Validation.validateWebsite(value!) != null
                                  ? Validation.validateWebsite(value)!
                                      .tr(context)
                                  : Validation.validateWebsite(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! ticketEventLink
                          CustomTextFormField(
                            labelText: AppStrings.ticketEventLink.tr(context),
                            controller: ticketEventLinkCreateEventController,
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! eventPrice
                          CustomTextFormField(
                            labelText: AppStrings.eventPrice.tr(context),
                            keyboardType: TextInputType.number,
                            controller: eventPriceCreateEventController,
                            validator: (value) {
                              return Validation.validateDouble(value!) != null
                                  ? Validation.validateDouble(value)!
                                      .tr(context)
                                  : Validation.validateDouble(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! eventDescription
                          CustomTextFormField(
                            hintText: AppStrings.eventDescription.tr(context),
                            maxLines: 5,
                            controller: eventDescriptionCreateEventController,
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          //! City
                          CustomDropDownButton(
                            items: GlobalCubit.get(context)
                                .egyptGovernorates
                                .map(
                                  (city) => DropdownMenuItem<String>(
                                    value: city,
                                    child: Text(
                                      city.tr(context),
                                      style:
                                          CustomTextStyle.roboto700sized14Grey,
                                    ),
                                  ),
                                )
                                .toList(),
                            label: AppStrings.city.tr(context),
                            labelStyle: CustomTextStyle.roboto700sized14Grey,
                            value: null,
                            onChanged: (value) {
                              if (value != null) {
                                HomeCubit.get(context)
                                    .updateSelectedCityCreateEvent(
                                  value.toString(),
                                );
                              }
                            },
                            validator: (p0) {
                              if (p0 == null) {
                                return AppStrings.thisFieldIsRequired
                                    .tr(context);
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomDropDownButton(
                            items: HomeCubit.get(context)
                                .homeCategories
                                .map(
                                  (category) => DropdownMenuItem<String>(
                                    value: category.id,
                                    child: Text(
                                      category.title ?? "",
                                      style:
                                          CustomTextStyle.roboto700sized14Grey,
                                    ),
                                  ),
                                )
                                .toList(),
                            label: AppStrings.eventCategory.tr(context),
                            labelStyle: CustomTextStyle.roboto700sized14Grey,
                            value: null,
                            onChanged: (value) {
                              HomeCubit.get(context)
                                  .updateSelectedCategoryIdCreateEvent(
                                value.toString(),
                              );
                            },
                            validator: (p0) {
                              if (p0 == null) {
                                return AppStrings.thisFieldIsRequired
                                    .tr(context);
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          // //! Organizer Plan
                          // CustomDropDownButton(
                          //   items: ["basic", "free", "standard", "premium"]
                          //       .map(
                          //         (plane) => DropdownMenuItem<String>(
                          //           value: plane,
                          //           child: Text(
                          //             plane.toUpperCase(),
                          //             style: CustomTextStyle
                          //                 .roboto700sized14Grey,
                          //           ),
                          //         ),
                          //       )
                          //       .toList(),
                          //   label: AppStrings.organizerPlan.tr(context),
                          //   labelStyle: CustomTextStyle.roboto700sized14Grey,
                          //   value: null,
                          //   validator: (p0) {
                          //     if (p0 == null) {
                          //       return AppStrings.thisFieldIsRequired
                          //           .tr(context);
                          //     }
                          //     return null;
                          //   },
                          //   onChanged: (value) {
                          //     HomeCubit.get(context)
                          //         .updateSelectedOrganizerPlan(
                          //       value.toString(),
                          //     );
                          //   },
                          // ),
                          // SizedBox(height: 16.h),
                          //! Event Date
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: HomeCubit.get(context)
                                        .selectedEventDateCreateEvent ??
                                    DateTime.now().add(const Duration(days: 1)),
                                firstDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                lastDate: DateTime(3000),
                              ).then((v) {
                                if (v != null) {
                                  HomeCubit.get(context)
                                      .updateSelectedEventDateCreateEvent(v);
                                }
                              });
                            },
                            child: CustomTextFormField(
                              enabled: false,
                              labelText: HomeCubit.get(context)
                                          .selectedEventDateCreateEvent !=
                                      null
                                  ? displayDate(
                                      HomeCubit.get(context)
                                          .selectedEventDateCreateEvent,
                                    )
                                  : AppStrings.eventDate.tr(context),
                              validator: (p0) {
                                if (HomeCubit.get(context)
                                        .selectedEventDateCreateEvent ==
                                    null) {
                                  return AppStrings.thisFieldIsRequired
                                      .tr(context);
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          //! Event start End Time
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDateTimePicker(
                                context,
                                minTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day + 1,
                                  0,
                                  0,
                                ),
                                currentTime: HomeCubit.get(context)
                                    .selectedStartTimeCreateEvent,
                                onConfirm: (time) {
                                  HomeCubit.get(context)
                                      .updateSelectedStarttime(time);
                                },
                              );
                            },
                            child: CustomTextFormField(
                              enabled: false,
                              labelText: displayDateAndTime(
                                      HomeCubit.get(context)
                                          .selectedStartTimeCreateEvent) ??
                                  AppStrings.startTime.tr(context),
                              validator: (p0) {
                                if (HomeCubit.get(context)
                                        .selectedStartTimeCreateEvent ==
                                    null) {
                                  return AppStrings.thisFieldIsRequired
                                      .tr(context);
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDateTimePicker(
                                context,
                                minTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day + 1,
                                  0,
                                  0,
                                ),
                                currentTime: HomeCubit.get(context)
                                    .selectedEndTimeCreateEvent,
                                onConfirm: (time) {
                                  HomeCubit.get(context)
                                      .updateSelectedEndtime(time);
                                },
                              );
                            },
                            child: CustomTextFormField(
                              enabled: false,
                              labelText: displayDateAndTime(
                                      HomeCubit.get(context)
                                          .selectedEndTimeCreateEvent) ??
                                  AppStrings.endTime.tr(context),
                              validator: (p0) {
                                if (HomeCubit.get(context)
                                        .selectedEndTimeCreateEvent ==
                                    null) {
                                  return AppStrings.thisFieldIsRequired
                                      .tr(context);
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 32.h),
                          //! *******************************************************************
                          CustomElevatedButton(
                            text: AppStrings.continuee.tr(context),
                            onPressed: () {
                              if (createEventFormKey.currentState!.validate()) {
                                if (HomeCubit.get(context).eventImage == null) {
                                  showTwist(
                                    context: context,
                                    messege:
                                        AppStrings.uploadEventImage.tr(context),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectPlanScreen(
                                        eventName: nameCreateEventController
                                            .text
                                            .trim(),
                                        eventAddress:
                                            addressCreateEventController.text
                                                .trim(),
                                        organizerName:
                                            organizerNameCreateEventController
                                                .text
                                                .trim(),
                                        organizationName:
                                            organizationNameCreateEventController
                                                .text
                                                .trim(),
                                        organizationPhoneNumber:
                                            organizationPhoneNumberCreateEventController
                                                .text
                                                .trim(),
                                        organizationEmail:
                                            organizationEmailCreateEventController
                                                .text
                                                .trim(),
                                        organizationWebsite:
                                            organizationWebsiteCreateEventController
                                                .text
                                                .trim(),
                                        ticketEventLink:
                                            ticketEventLinkCreateEventController
                                                .text
                                                .trim(),
                                        eventPrice:
                                            eventPriceCreateEventController.text
                                                .trim(),
                                        eventDescription:
                                            eventDescriptionCreateEventController
                                                .text
                                                .trim(),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          SizedBox(height: 64.h),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CreateEventAppBar extends StatelessWidget {
  const CreateEventAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 48.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            Colors.deepOrange.shade800,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.createEvent.tr(context),
            style: CustomTextStyle.roboto700sized20White,
          ),
        ],
      ),
    );
  }
}

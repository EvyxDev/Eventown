import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/common/common.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class SelectPlanScreen extends StatelessWidget {
  const SelectPlanScreen({
    super.key,
    required this.eventName,
    required this.eventAddress,
    required this.organizerName,
    required this.organizationName,
    required this.organizationPhoneNumber,
    required this.organizationEmail,
    required this.organizationWebsite,
    required this.ticketEventLink,
    required this.eventPrice,
    required this.eventDescription,
  });

  final String eventName;
  final String eventAddress;
  final String organizerName;
  final String organizationName;
  final String organizationPhoneNumber;
  final String organizationEmail;
  final String organizationWebsite;
  final String ticketEventLink;
  final String eventPrice;
  final String eventDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is CreateEventSuccess) {
            HomeCubit.get(context).clearDate();
            Navigator.pop(context);
            Navigator.pop(context);
            showTwist(
                context: context,
                messege: AppStrings.eventCreatedSuccessfuly.tr(context));
          } else if (state is CreateEventError) {
            showTwist(context: context, messege: state.message);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is CreateEventLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: Column(
              children: [
                Container(
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
                        AppStrings.selectPlan.tr(context),
                        style: CustomTextStyle.roboto700sized20White,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.separated(
                      itemCount: context.read<HomeCubit>().plans.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final plan = context.read<HomeCubit>().plans[index];
                        return InkWell(
                          onTap: () {
                            context
                                .read<HomeCubit>()
                                .updateSelectedOrganizerPlan(plan['planName']);
                          },
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.w,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 25.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    color: context
                                                .read<HomeCubit>()
                                                .selectedorganizerPlan ==
                                            plan['planName']
                                        ? AppColors.primary
                                        : AppColors.black,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2.w,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        plan['planName'].toUpperCase(),
                                        style: CustomTextStyle
                                            .roboto700sized20Primary,
                                      ),
                                      //  plan["features"] as list of strings
                                      Column(
                                        children: List.generate(
                                            plan["features"].length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              '- ${plan["features"][index]}',
                                              style: CustomTextStyle
                                                  .roboto400sized14Grey,
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.start,
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomElevatedButton(
                    text: AppStrings.createEvent.tr(context),
                    onPressed: () {
                      context.read<HomeCubit>().createEvent(
                            eventName: eventName,
                            eventAddress: eventAddress,
                            organizerName: organizerName,
                            organizationName: organizationName,
                            organizationPhoneNumber: organizationPhoneNumber,
                            organizationEmail: organizationEmail,
                            organizationWebsite: organizationWebsite,
                            ticketEventLink: ticketEventLink,
                            eventPrice: eventPrice,
                            eventDescription: eventDescription,
                          );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

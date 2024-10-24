import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                Colors.deepOrange.shade800,
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.myCalendar.tr(context),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.assetsImagesSvgIconPlaceholder,
                  width: 36.w,
                  height: 36.h,
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Column(
            children: [
              Expanded(
                child: state is GetCalenderEventsLoading
                    ? const CustomLoadingIndicator()
                    : cubit.userCalender.isEmpty
                        ? Text(AppStrings.noEventsFound.tr(context))
                        : ListView.builder(
                            itemCount: cubit.userCalender.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.userCalender[index].eventName ?? "",
                                      style:
                                          CustomTextStyle.roboto500sized20White,
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: AppColors.white,
                                          size: 16.r,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          displayDate(cubit.userCalender[index]
                                                  .eventDate) ??
                                              "",
                                          style: CustomTextStyle
                                              .roboto400sized14White,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: AppColors.white,
                                          size: 16.r,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          convertTime(
                                            cubit.userCalender[index].eventDate,
                                          ),
                                          style: CustomTextStyle
                                              .roboto400sized14White,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: AppColors.white,
                                          size: 16.r,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          cubit.userCalender[index]
                                                  .eventLocation ??
                                              "",
                                          style: CustomTextStyle
                                              .roboto400sized14White,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}

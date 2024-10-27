import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Expanded(
                  child: state is GetCalenderEventsLoading
                      ? const CustomLoadingIndicator()
                      : cubit.userCalender.isEmpty
                          ? Center(
                              child: Text(AppStrings.noEventsFound.tr(context)))
                          : RefreshIndicator(
                              onRefresh: () {
                                return context
                                    .read<HomeCubit>()
                                    .getUserCalender();
                              },
                              backgroundColor: AppColors.white,
                              child: ListView.builder(
                                itemCount: cubit.userCalender.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 255.h,
                                    child: EventCard(
                                      event: cubit.userCalender[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

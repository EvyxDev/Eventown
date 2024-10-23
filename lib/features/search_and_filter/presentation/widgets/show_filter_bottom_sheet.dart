import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_drop_down_button.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

showFilterBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            color: AppColors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.filter.tr(context),
                          style: CustomTextStyle.roboto700sized20White,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomDropDownButton(
                    label: AppStrings.categories.tr(context),
                    items: context.read<HomeCubit>().homeCategories.map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.title ?? ""),
                      );
                    }).toList(),
                    onChanged: (v) {
                      context
                          .read<HomeCubit>()
                          .updateSelectedCategoryId(v.toString());
                    },
                    value: context.read<HomeCubit>().selectedCategoryId,
                  ),
                  _buildDateRangeField(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.sortByPriceLowToHigh.tr(context),
                        style: CustomTextStyle.roboto500sized16White,
                      ),
                      Checkbox(
                          value:
                              context.read<HomeCubit>().isSortByPriceLowToHigh,
                          onChanged: (v) {
                            context.read<HomeCubit>().sortByPriceLowToHigh();
                          })
                    ],
                  ),
                  CustomElevatedButton(
                    text: AppStrings.searchAndApplyFilters.tr(context),
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().searchEventsByQuery();
                      // context.read<HomeCubit>().clearSearch();
                    },
                    elevation: 0,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildDateRangeField(BuildContext context) {
  String formattedStartDate = DateFormat('MMM dd')
      .format(context.read<HomeCubit>().startDate ?? DateTime.now());
  String formattedEndDate = DateFormat('MMM dd').format(
      context.read<HomeCubit>().endDate ??
          DateTime.now().add(const Duration(days: 7)));
  String dateRangeText =
      context.read<HomeCubit>().startDate == context.read<HomeCubit>().endDate
          ? formattedStartDate
          : '$formattedStartDate - $formattedEndDate';

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    child: GestureDetector(
      onTap: () async {
        final DateTimeRange? pickedRange = await showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
            start: context.read<HomeCubit>().startDate ?? DateTime.now(),
            end: context.read<HomeCubit>().endDate ??
                DateTime.now().add(const Duration(days: 7)),
          ),
          firstDate: DateTime.now(),
          lastDate: DateTime(3101),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  onPrimary: Colors.white,
                  secondary: AppColors.primary,
                  surface: Colors.black,
                ),
                dialogBackgroundColor: Colors.grey[900],
              ),
              child: child!,
            );
          },
        );
        if (pickedRange != null) {
          context.read<HomeCubit>().updateStartAndEndData(
                pickedRange.start,
                pickedRange.end,
              );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.read<HomeCubit>().endDate == null ||
                    context.read<HomeCubit>().startDate == null
                ? AppStrings.selectDateRange.tr(context)
                : dateRangeText,
            style: CustomTextStyle.roboto500sized16White,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: const Icon(
              Icons.calendar_today,
              size: 22,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    ),
  );
}

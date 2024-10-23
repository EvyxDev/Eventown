import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/search_and_filter/presentation/widgets/filter_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FiltersOptionsSection extends StatelessWidget {
  const FiltersOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        String formattedStartDate = DateFormat('MMM dd')
            .format(context.read<HomeCubit>().startDate ?? DateTime.now());
        String formattedEndDate = DateFormat('MMM dd').format(
            context.read<HomeCubit>().endDate ??
                DateTime.now().add(const Duration(days: 7)));
        String dateRangeText = context.read<HomeCubit>().startDate ==
                context.read<HomeCubit>().endDate
            ? formattedStartDate
            : '$formattedStartDate - $formattedEndDate';
        return cubit.isFiltersApplied()
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        cubit.isSortByPriceLowToHigh
                            ? FilterOption(
                                label:
                                    AppStrings.sortByPriceLowToHigh.tr(context),
                                onTap: () {
                                  cubit.sortByPriceLowToHigh();
                                  cubit.searchEventsByQuery();
                                },
                              )
                            : const SizedBox.shrink(),
                        SizedBox(width: 8.w),
                        cubit.selectedCategoryId != null
                            ? FilterOption(
                                label: cubit.homeCategories
                                        .firstWhere((element) =>
                                            element.id ==
                                            cubit.selectedCategoryId)
                                        .title ??
                                    "",
                                onTap: () {
                                  cubit.updateSelectedCategoryId(null);
                                  cubit.searchEventsByQuery();
                                },
                              )
                            : const SizedBox.shrink(),
                        SizedBox(width: 8.w),
                        cubit.startDate != null || cubit.endDate != null
                            ? FilterOption(
                                label: dateRangeText,
                                onTap: () {
                                  cubit.updateStartAndEndData(null, null);
                                  cubit.searchEventsByQuery();
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              );
      },
    );
  }
}
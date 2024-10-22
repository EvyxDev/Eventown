import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_drop_down_button.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SearchAndFilterScreen extends StatelessWidget {
  SearchAndFilterScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Listen to scroll events to trigger load more
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context.read<HomeCubit>().searchEventsByQuery(loadMore: true);
        }
      },
    );
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Form(
              key: context.read<HomeCubit>().searchFormKey,
              child: CustomTextFormField(
                fillColor: AppColors.white,
                controller: context.read<HomeCubit>().searchController,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 6.h,
                ),
                borderColor: AppColors.white,
                borderRadius: 8.r,
                style: CustomTextStyle.roboto700sized12Grey,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey,
                ),
                hintText: AppStrings.search.tr(context),
                hintStyle: CustomTextStyle.roboto700sized12Grey,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
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
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
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
                  value: null,
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
                        value: context.read<HomeCubit>().isSortByPriceLowToHigh,
                        onChanged: (v) {
                          context.read<HomeCubit>().sortByPriceLowToHigh();
                        })
                  ],
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(
                  text: AppStrings.searchAndApplyFilters.tr(context),
                  onPressed: () {
                    context.read<HomeCubit>().searchEventsByQuery();
                  },
                  elevation: 0,
                ),
                SizedBox(height: 16.h),
                Builder(
                  builder: (context) {
                    if (state is SearchEventsLoading) {
                      return const Center(child: CustomLoadingIndicator());
                    } else if (state is SearchEventsError) {
                      return Center(
                        child: Text(
                          AppStrings.noEventsFound.tr(context),
                        ),
                      );
                    } else {
                      return context.read<HomeCubit>().searchEvents.isEmpty
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      AppStrings.noEventsFound.tr(context),
                                      style:
                                          CustomTextStyle.roboto700sized14Grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount: context
                                        .read<HomeCubit>()
                                        .searchHasMoreEvents
                                    ? context
                                            .read<HomeCubit>()
                                            .searchEvents
                                            .length +
                                        1
                                    : context
                                        .read<HomeCubit>()
                                        .searchEvents
                                        .length,
                                itemBuilder: (context, index) {
                                  if (index ==
                                      context
                                          .read<HomeCubit>()
                                          .searchEvents
                                          .length) {
                                    // Show a loading indicator at the end of the list
                                    return Center(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: const CustomLoadingIndicator(),
                                    ));
                                  }
                                  return SizedBox(
                                    height: 225.h,
                                    child: EventCard(
                                        event: context
                                            .read<HomeCubit>()
                                            .searchEvents[index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 16.h);
                                },
                              ),
                            );
                    }
                  },
                )
              ],
            ),
          ),
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
}

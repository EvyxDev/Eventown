import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:eventown/features/search_and_filter/presentation/widgets/filter_options_section.dart';
import 'package:eventown/features/search_and_filter/presentation/widgets/show_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
        final HomeCubit cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.black,
            centerTitle: false,
            title: Text(
              AppStrings.search.tr(context),
              style: CustomTextStyle.roboto700sized20White,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60.h),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Form(
                        key: cubit.searchFormKey,
                        child: CustomTextFormField(
                          fillColor: AppColors.white,
                          controller: cubit.searchController,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          autofocus: false,
                          borderColor: AppColors.white,
                          borderRadius: 8.r,
                          style: CustomTextStyle.roboto700sized12Grey,
                          prefixIcon: GestureDetector(
                            onTap: () {
                              cubit.searchEventsByQuery();
                            },
                            child: const Icon(
                              Icons.search,
                              color: AppColors.grey,
                            ),
                          ),
                          hintText: AppStrings.search.tr(context),
                          hintStyle: CustomTextStyle.roboto700sized12Grey,
                          onFieldSubmitted: (v) {
                            cubit.searchEventsByQuery();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        showFilterBottomSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 13.h),
                          child: SvgPicture.asset(
                            Assets.assetsImagesSvgFilter,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
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
                Builder(
                  builder: (context) {
                    if (state is SearchEventsLoading) {
                      return const Center(
                        child: Column(
                          children: [
                            FiltersOptionsSection(),
                            CustomLoadingIndicator(),
                          ],
                        ),
                      );
                    } else if (state is SearchEventsError) {
                      return Center(
                        child: Text(
                          AppStrings.noEventsFound.tr(context),
                        ),
                      );
                    } else {
                      return cubit.searchEvents.isEmpty
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FiltersOptionsSection(),
                                  Text(
                                    AppStrings.noEventsFound.tr(context),
                                    style: CustomTextStyle.roboto700sized14Grey,
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FiltersOptionsSection(),
                                  Expanded(
                                    child: ListView.separated(
                                      controller: _scrollController,
                                      itemCount: cubit.searchHasMoreEvents
                                          ? cubit.searchEvents.length + 1
                                          : cubit.searchEvents.length,
                                      itemBuilder: (context, index) {
                                        if (index ==
                                            cubit.searchEvents.length) {
                                          // Show a loading indicator at the end of the list
                                          return Center(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h),
                                            child:
                                                const CustomLoadingIndicator(),
                                          ));
                                        }
                                        return SizedBox(
                                          height: 225.h,
                                          child: EventCard(
                                              event: cubit.searchEvents[index]),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 16.h);
                                      },
                                    ),
                                  ),
                                ],
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
}

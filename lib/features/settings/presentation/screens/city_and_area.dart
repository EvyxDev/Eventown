import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_drop_down_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CityAndArea extends StatelessWidget {
  CityAndArea({super.key});
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
              AppStrings.cityAndArea.tr(context),
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                CustomDropDownButton(
                  items: GlobalCubit.get(context)
                      .egyptGovernorates
                      .map(
                        (city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(
                            city.tr(context),
                            style: CustomTextStyle.roboto700sized14Grey,
                          ),
                        ),
                      )
                      .toList(),
                  label: AppStrings.city.tr(context),
                  labelStyle: CustomTextStyle.roboto700sized14Grey,
                  value: null,
                  onChanged: (value) {
                    context.read<HomeCubit>().updateSelectedCity(
                          value.toString(),
                        );
                    context.read<HomeCubit>().searchEventsByQuery();
                  },
                ),
                SizedBox(height: 16.h),
                Builder(
                  builder: (context) {
                    if (state is SearchEventsLoading) {
                      return const Center(
                        child: CustomLoadingIndicator(),
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

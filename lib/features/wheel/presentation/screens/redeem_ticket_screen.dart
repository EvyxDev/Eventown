import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:eventown/features/search_and_filter/presentation/widgets/filter_options_section.dart';
import 'package:eventown/features/search_and_filter/presentation/widgets/show_filter_bottom_sheet.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_cubit.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RedeemTicketScreen extends StatefulWidget {
  const RedeemTicketScreen({super.key});

  @override
  State<RedeemTicketScreen> createState() => _RedeemTicketScreenState();
}

class _RedeemTicketScreenState extends State<RedeemTicketScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<HomeCubit>().searchEventsByQuery();

    super.initState();
  }

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
    var cubit = context.read<HomeCubit>();

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          centerTitle: false,
          title: Text(
            AppStrings.redeemTicket.tr(context),
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
                      showFilterBottomSheet(context, () {
                        Navigator.pop(context);
                        context.read<HomeCubit>().searchEventsByQuery();
                        // context.read<HomeCubit>().clearSearch();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 11.h),
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
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),
                  const SelectedEventsSection(),
                  SizedBox(height: 16.h),
                  Builder(
                    builder: (context) {
                      if (state is SearchEventsLoading) {
                        return const Center(
                          child: Column(
                            children: [
                              FiltersOptionsSection(isViewAll: false),
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
                                    const FiltersOptionsSection(
                                        isViewAll: false),
                                    Text(
                                      AppStrings.noEventsFound.tr(context),
                                      style:
                                          CustomTextStyle.roboto700sized14Grey,
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FiltersOptionsSection(
                                        isViewAll: false),
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
                                            child: Stack(
                                              children: [
                                                EventCard(
                                                  event:
                                                      cubit.searchEvents[index],
                                                  width: double.infinity,
                                                ),
                                                Center(
                                                  child: BlocBuilder<GameCubit,
                                                      GameState>(
                                                    builder: (context, state) {
                                                      return CustomElevatedButton(
                                                        text: context
                                                                .read<
                                                                    GameCubit>()
                                                                .isEventSelected(
                                                                    cubit.searchEvents[
                                                                        index])
                                                            ? "Unselect"
                                                            : "Select",
                                                        color: AppColors.white,
                                                        textColor:
                                                            AppColors.primary,
                                                        onPressed: () {
                                                          context
                                                              .read<GameCubit>()
                                                              .updateSelectedEvents(
                                                                context,
                                                                cubit.searchEvents[
                                                                    index],
                                                              );
                                                        },
                                                        width: 150,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
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
                  ),
                  SizedBox(height: 16.h),
                  BlocConsumer<GameCubit, GameState>(
                    listener: (context, state) {
                      if (state is RequestFreeTicketSuccess) {
                        Navigator.pop(context);
                        showTwist(
                          context: context,
                          messege: "Request sent successfully",
                        );
                      } else if (state is RequestFreeTicketError) {
                        showTwist(
                          context: context,
                          messege: state.message,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButton(
                        text: AppStrings.redeemTicket.tr(context),
                        color:
                            context.read<GameCubit>().selectedEvents.length == 3
                                ? AppColors.primary
                                : AppColors.grey,
                        onPressed: () {
                          if (context.read<GameCubit>().selectedEvents.length ==
                              3) {
                            context.read<GameCubit>().requestFreeTicket(
                                  name: context
                                          .read<GlobalCubit>()
                                          .user
                                          ?.data
                                          ?.name ??
                                      "",
                                  email: context
                                          .read<GlobalCubit>()
                                          .user
                                          ?.data
                                          ?.email ??
                                      "",
                                  phone: context
                                          .read<GlobalCubit>()
                                          .user
                                          ?.data
                                          ?.phone ??
                                      "",
                                  address: context
                                          .read<GlobalCubit>()
                                          .user
                                          ?.data
                                          ?.location ??
                                      "",
                                );
                          }
                        },
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SelectedEventsSection extends StatelessWidget {
  const SelectedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        var cubit = context.read<GameCubit>();
        return SizedBox(
          height: 50.h,
          child: cubit.selectedEvents.isEmpty
              ? Center(
                  child: Text(
                  "Select 3 events for free",
                  style: CustomTextStyle.roboto700sized14Grey,
                ))
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.updateSelectedEvents(
                                context,
                                cubit.selectedEvents[index],
                              );
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            cubit.selectedEvents[index].eventName ?? "",
                            textAlign: TextAlign.start,
                            style: CustomTextStyle.roboto700sized16Primary,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 16.w);
                  },
                  itemCount: cubit.selectedEvents.length,
                ),
        );
      },
    );
  }
}

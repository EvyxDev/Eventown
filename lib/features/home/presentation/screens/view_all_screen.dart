import 'package:eventown/core/common/common.dart';
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

class ViewAllScreen extends StatelessWidget {
  ViewAllScreen({
    super.key,
    required this.eventsType,
    required this.title,
  });
  final EventsType eventsType;
  final String title;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Listen to scroll events to trigger load more
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context
              .read<HomeCubit>()
              .getViewAllEvents(loadMore: true, type: eventsType);
        }
      },
    );
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
          title,
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
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetViewAllError) {
            showTwist(
                context: context,
                messege: 'Error: ${state.message}',
                state: ToastStates.success);
          }
        },
        builder: (context, state) {
          if (state is GetViewAllLoading) {
            return const Center(child: CustomLoadingIndicator());
          } else if (state is GetViewAllError) {
            return Center(
              child: Text(
                AppStrings.noEventsFound.tr(context),
              ),
            );
          } else {
            return context.read<HomeCubit>().viewAllEvents.isEmpty
                ? Center(
                    child: Text(
                      AppStrings.noEventsFound.tr(context),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 24.h,
                    ),
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: context.read<HomeCubit>().hasMoreEvents
                          ? context.read<HomeCubit>().viewAllEvents.length + 1
                          : context.read<HomeCubit>().viewAllEvents.length,
                      itemBuilder: (context, index) {
                        if (index ==
                            context.read<HomeCubit>().viewAllEvents.length) {
                          // Show a loading indicator at the end of the list
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const CustomLoadingIndicator(),
                          ));
                        }
                        return SizedBox(
                          height: 225.h,
                          child: EventCard(
                              event: context
                                  .read<HomeCubit>()
                                  .viewAllEvents[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16.h);
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
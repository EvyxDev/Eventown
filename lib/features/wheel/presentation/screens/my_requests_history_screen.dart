import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_cubit.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRequestsHistoryScreen extends StatefulWidget {
  const MyRequestsHistoryScreen({super.key});

  @override
  State<MyRequestsHistoryScreen> createState() =>
      _MyRequestsHistoryScreenState();
}

class _MyRequestsHistoryScreenState extends State<MyRequestsHistoryScreen> {
  @override
  void initState() {
    context.read<GameCubit>().getMyRequestsHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
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
                    Align(
                      child: Text(
                        AppStrings.ticketHistory.tr(context),
                        style: CustomTextStyle.roboto700sized20White,
                      ),
                    ),
                  ],
                ),
              ),
              state is GetMyRequestsHistoryLoading
                  ? const Center(
                      child: CustomLoadingIndicator(),
                    )
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: context
                              .read<GameCubit>()
                              .myRequestsHistory
                              .length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 255.h,
                              child: EventCard(
                                event: context
                                    .read<GameCubit>()
                                    .myRequestsHistory[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}

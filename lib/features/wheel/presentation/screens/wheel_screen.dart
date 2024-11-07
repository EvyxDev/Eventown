import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/wheel/data/repositories/wheel_repo.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_cubit.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_state.dart';
import 'package:eventown/features/wheel/presentation/screens/redeem_ticket_screen.dart';
import 'package:eventown/features/wheel/presentation/widgets/gradient_progress_indicator.dart';
import 'package:eventown/features/wheel/presentation/widgets/review_card_image.dart';
import 'package:eventown/features/wheel/presentation/widgets/spin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class WheelScreen extends StatelessWidget {
  const WheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameCubit, GameState>(
        listener: (context, state) {
          if (state is GetMyPointsError) {
            showTwist(context: context, messege: state.message);
          }
          if (state is AddCommentError) {
            showTwist(context: context, messege: state.message);
          }

          if (state is AddCommentSuccess) {
            showTwist(
              context: context,
              messege: AppStrings.commentCreatedSuccessfully.tr(context),
            );
          }

          if (state is AddPointsToMyAccountError) {
            showTwist(context: context, messege: state.message);
          }
        },
        builder: (context, state) {
          var cubit = context.read<GameCubit>();
          final remainingTime = cubit.getRemainingTime();
          return ModalProgressHUD(
            inAsyncCall: state is GetMyPointsLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            AppStrings.welcomeToSpinAndWin.tr(context),
                            style: CustomTextStyle.roboto700sized20White,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        Text(
                          "${AppStrings.aboutSpinAndWin.tr(context)} :",
                          style: CustomTextStyle.roboto500sized14Primary,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          AppStrings
                              .earnEverydayachancetowinafreeeventticketcollectpointsnowafterspinngthewheel
                              .tr(context),
                          style: CustomTextStyle.roboto400sized14Grey,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppStrings.howToPlaySpinAndWin.tr(context)} : ",
                              style: CustomTextStyle.roboto500sized14Primary,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              AppStrings.spinAndWinInstructions.tr(context),
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Center(
                          child: progressIndicatorWithPoints(
                            cubit.myPoint / cubit.totalPoints,
                            context,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        buildFortuneWheel(context),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: spinButton(
                                remainingTime,
                                cubit.selected,
                                cubit.items,
                                context,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (_) => Ticket_History_Screen(),
                                  //     ),
                                  // );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      AppStrings.ticketHistory.tr(context),
                                      style:
                                          CustomTextStyle.roboto400sized14White,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        const Divider(color: AppColors.primary, thickness: 1),
                        SizedBox(height: 24.h),
                        Text(
                          AppStrings.redeemButtonActivation.tr(context),
                          style: CustomTextStyle.roboto700sized20Primary,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 24.h),
                        GestureDetector(
                          onTap: () {
                            if (cubit.myPoint >= 1000) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider(
                                      create: (context) =>
                                          GameCubit(sl<WheelRepo>()),
                                      child: const RedeemTicketScreen(),
                                    );
                                  },
                                ),
                              ).whenComplete(
                                () {
                                  cubit.getGameData();
                                },
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: cubit.myPoint >= 1000
                                      ? AppColors.primary
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                              color: cubit.myPoint >= 1000
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.redeemTicket.tr(context),
                                style: CustomTextStyle.roboto400sized14White,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppStrings.howToRedeemYourTicket.tr(context)} :",
                              style: CustomTextStyle.roboto500sized14Primary,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              AppStrings.redeemTicketInstructions.tr(context),
                              style: CustomTextStyle.roboto400sized14Grey,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        const Divider(color: AppColors.primary, thickness: 1),
                        SizedBox(height: 24.h),
                        Text(
                          AppStrings.joinOurGreatEvents.tr(context),
                          style: CustomTextStyle.roboto700sized20Primary,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 24.h),
                        Text("${AppStrings.previousWinners.tr(context)}: ",
                            style: CustomTextStyle.roboto400sized20Primary),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          hintText: AppStrings.writeYourComment.tr(context),
                          suffixIcon: InkWell(
                            onTap: () async {
                              if (cubit.commentController.text.isNotEmpty) {
                                cubit.addComment(context);
                                cubit.commentController.clear();
                              }
                            },
                            child: const Icon(
                              Icons.send,
                              color: AppColors.primary,
                            ),
                          ),
                          controller: cubit.commentController,
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          children: List.generate(
                            cubit.allComments.length,
                            (index) {
                              return ReviewCardGame(
                                title: cubit.allComments[index].text ?? "",
                                content: cubit.allComments[index].text ?? "",
                                userName:
                                    cubit.allComments[index].user?.name ?? "",
                                timeAgo: displayDateAndTime(
                                        cubit.allComments[index].createdAt) ??
                                    "",
                                userImage:
                                    cubit.allComments[index].user?.profileImg,
                                img: cubit.allComments[index].img,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 150.h),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildFortuneWheel(BuildContext context) {
  var cubit = context.read<GameCubit>();
  return SizedBox(
    height: 300.h,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 20,
          ),
        ],
      ),
      child: FortuneWheel(
        selected: cubit.selected.stream,
        indicators: <FortuneIndicator>[
          FortuneIndicator(
            alignment: Alignment
                .topCenter, // <-- changing the position of the indicator
            child: TriangleIndicator(
              color:
                  AppColors.primary, // <-- changing the color of the indicator
              width: 20.w, // <-- changing the width of the indicator
              height: 20.h, // <-- changing the height of the indicator
              elevation: 4, // <-- changing the elevation of the indicator
            ),
          ),
        ],
        onAnimationEnd: () {
          if (cubit.selected.hasValue) {
            final int rewardValue = cubit.items[cubit.selected.value];
            cubit.addPointsToMyAccount(rewardValue);
            cubit.lastSpinTime = DateTime.now();
            cubit.saveLastSpinTime();
          }
        },
        items: [
          for (var item in cubit.items)
            FortuneItem(
              style: FortuneItemStyle(
                  color: Colors.orange.shade900,
                  borderColor: Colors.orange.shade600),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: const SizedBox(),
                    ),
                    Text(
                      item.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    ),
  );
}

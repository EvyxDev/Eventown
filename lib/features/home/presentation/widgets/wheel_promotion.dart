import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../../core/utils/app_text_styles.dart';

class WheelPromotion extends StatelessWidget {
  const WheelPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GlobalCubit>().changeBottom(1);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            WidgetAnimator(
              // incomingEffect: WidgetTransitionEffects(
              //     delay: const Duration(
              //       milliseconds: 1500,
              //     ),
              //     offset: const Offset(0, -30),
              //     curve: Curves.easeInCirc,
              //     duration: const Duration(milliseconds: 900)),
              atRestEffect: WidgetRestingEffects.rotate(),
              child: Image.asset(
                Assets.assetsImagesPngWheel,
                width: 80.w,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.wheelOfFortune.tr(context),
                    style: CustomTextStyle.roboto700sized18Primary,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings
                        .feelingLuckyTestYourFortuneOnOurGameWheelGatherPointsWithEverySpinToWinTicketsToUpcomingEvents
                        .tr(context),
                    style: CustomTextStyle.roboto400sized12Secoundry,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

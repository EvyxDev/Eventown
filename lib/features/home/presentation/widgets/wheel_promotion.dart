import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../../core/utils/app_text_styles.dart';

class WheelPromotion extends StatelessWidget {
  const WheelPromotion({
    super.key,
    required this.index,
  });
  final int index;

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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.read<HomeCubit>().wheelPromotions[index]['title'],
                    style: CustomTextStyle.roboto700sized16Primary,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.read<HomeCubit>().wheelPromotions[index]
                        ['description'],
                    style: CustomTextStyle.roboto400sized12Secoundry,
                    maxLines: 3,
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

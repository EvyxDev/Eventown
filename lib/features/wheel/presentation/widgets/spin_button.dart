import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_cubit.dart';
import 'package:eventown/features/wheel/presentation/cubit/game_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

Widget spinButton(Duration remainingTime, BehaviorSubject<int> selected,
    List<int> items, BuildContext context) {
  final formattedTime = formatDuration(remainingTime);
  return SpinButton(formattedTime: formattedTime);
}

class SpinButton extends StatefulWidget {
  const SpinButton({super.key, required this.formattedTime});

  final String formattedTime;

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: context.read<GameCubit>().getRemainingTime() <= Duration.zero
              ? () => context.read<GameCubit>().selected.add(
                  Fortune.randomInt(0, context.read<GameCubit>().items.length))
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
                color: (context.read<GameCubit>().getRemainingTime() <=
                        Duration.zero
                    ? AppColors.primary
                    : Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              context.read<GameCubit>().getRemainingTime() <= Duration.zero
                  ? AppStrings.spin.tr(context)
                  : "${AppStrings.spin.tr(context)} ${widget.formattedTime}",
              style: CustomTextStyle.roboto500sized14White,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

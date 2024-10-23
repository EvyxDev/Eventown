import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget progressIndicatorWithPoints(double value, context) {
  return Stack(
    alignment: Alignment.center,
    children: [
      GradientProgressIndicator(value: value),
      Text(
        '${(value * 1000).toInt()} / 1000 ${AppStrings.points.tr(context)}',
        style: CustomTextStyle.roboto500sized14Black,
      )
    ],
  );
}

class GradientProgressIndicator extends StatelessWidget {
  final double value; // Progress value, 0.0 to 1.0
  const GradientProgressIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientProgressIndicatorPainter(value: value),
      child: SizedBox(
        width: double.infinity,
        height: 42.h,
      ),
    );
  }
}

class _GradientProgressIndicatorPainter extends CustomPainter {
  final double value;
  _GradientProgressIndicatorPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    var backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Foreground with Gradient
    var progressPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, Colors.deepOrange.shade800],
      ).createShader(Rect.fromLTWH(0, 0, size.width * value, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * value, size.height), progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

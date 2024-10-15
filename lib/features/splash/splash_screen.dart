import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkingBeforeNavigation();
  }

  void checkingBeforeNavigation() async {
    String? token = sl<CacheHelper>().getData(key: AppConstants.token);
    bool firstTime =
        sl<CacheHelper>().getData(key: AppConstants.isFirstTime) ?? true;

    if (token != null) {
      printGreen("TOKEN: $token");
    } else {
      printRed("TOKEN: $token");
    }
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (token != null) {
          //base screen
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.base,
            (route) => false,
          );
        } else {
          if (firstTime) {
            //on boarding screen
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.onBoarding,
              (route) => false,
            );
          } else {
            //sign in screen
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.signIn,
              (route) => false,
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                Assets.assetsImagesSvgLogo,
                width: 200.w,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              AppStrings.appName.tr(context),
              style: TextStyle(
                fontSize: 32.sp,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

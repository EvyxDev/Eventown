import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/features/base/layout.dart';
import 'package:eventown/features/forgot_password/data/repositories/forgot_password_repo.dart';
import 'package:eventown/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:eventown/features/forgot_password/presentation/screens/forgot_password_otp_screen.dart';
import 'package:eventown/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:eventown/features/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:eventown/features/home/presentation/screens/home_screen.dart';
import 'package:eventown/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:eventown/features/sign_in/data/repositories/sign_in_repo.dart';
import 'package:eventown/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:eventown/features/sign_in/presentation/screens/sign_in_screen.dart';
import 'package:eventown/features/sign_up/data/repositories/sign_up_repo.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:eventown/features/sign_up/presentation/screens/otp_screen.dart';
import 'package:eventown/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:eventown/features/sign_up/presentation/screens/terms_and_conditions.dart';
import 'package:eventown/features/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = "/";
  static const String onBoarding = "/on-boarding";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String homeScreen = "/home-screen";
  static const String forgotPassword = "/forgot-password";
  static const String forgotPasswordOtp = "/forgot-password-Otp";
  static const String signDriverDetails = "/SignDriverDetails";
  static const String otp = "/otp";
  static const String base = "/base";
  static const String resetPassword = "/reset-password";
  static const String termsAndConditions = "/terms-and-conditions";
}

class AppRoutes {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //!Splash Screen
      case (Routes.initialRoute):
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      //!On Boarding Screen
      case (Routes.onBoarding):
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      //!Base Screen
      case (Routes.base):
        return MaterialPageRoute(
          builder: (_) => const BaseScreen(),
        );
      //!Sign in Screen
      case (Routes.signIn):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInCubit(sl<SignInRepo>()),
            child: const SignInScreen(),
          ),
        );
      //!Sign up Screen
      case (Routes.signUp):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                SignUpCubit(sl<SignUpRepo>())..getAllCategories(),
            child: const SignUpScreen(),
          ),
        );
      //! termsAndConditions Screen
      case (Routes.termsAndConditions):
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsScreen(),
        );
      //! Forgot Password Screen
      case (Routes.forgotPassword):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(sl<ForgotPasswordRepo>()),
            child: const ForgotPasswordScreen(),
          ),
        );
      //! Forgot Password Otp Screen
      case (Routes.forgotPasswordOtp):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(sl<ForgotPasswordRepo>()),
            child: const ForgotPasswordOtpScreen(),
          ),
        );
      // //! Reset Password Password Screen
      case (Routes.resetPassword):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(sl<ForgotPasswordRepo>()),
            child: const ResetPasswordScreen(),
          ),
        );
      //! OTP Password Screen
      case (Routes.otp):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpCubit(sl<SignUpRepo>()),
            child: const OtpScreen(),
          ),
        );
      //!Home Screen
      case (Routes.homeScreen):
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Found Route'),
            ),
          ),
        );
    }
  }
}

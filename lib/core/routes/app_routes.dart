import 'package:eventown/features/base/layout.dart';
import 'package:eventown/features/home/presentation/screens/home_screen.dart';
import 'package:eventown/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:eventown/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:eventown/features/sign_in/presentation/screens/sign_in_screen.dart';
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
  static const String signDriverDetails = "/SignDriverDetails";
  static const String otp = "/otp";
  static const String base = "/base";
  static const String resetPassword = "/reset-password";
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
            create: (context) => SignInCubit(),
            child: const SignInScreen(),
          ),
        );
      // //!Sign up Screen
      // case (Routes.signUp):
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => SignUpCubit(),
      //       child: const SignUpScreen(),
      //     ),
      //   );
      // //! Forgot Password Screen
      // case (Routes.forgotPassword):
      //   return MaterialPageRoute(
      //     builder: (_) => const ForgetPasswordScreen(),
      //   );
      // //! Reset Password Password Screen
      // case (Routes.resetPassword):
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => ForgetPasswordCubit(),
      //       child: const ResetPasswordScreen(),
      //     ),
      //   );
      // //! OTP Password Screen
      // case (Routes.otp):
      //   return MaterialPageRoute(
      //     builder: (_) => const OTPScreen(),
      //   );
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

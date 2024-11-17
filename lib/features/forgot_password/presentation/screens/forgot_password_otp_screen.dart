import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:eventown/features/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (outerContext, state) {
          if (state is OtpForgotPasswordSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              outerContext,
              Routes.resetPassword,
              (route) => false,
            );
          } else if (state is OtpForgotPasswordFailed) {
            showTwist(
              context: outerContext,
              messege: state.message,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 64.h),
                Text(
                  AppStrings.interThePINCodeHere.tr(context),
                  style: CustomTextStyle.roboto700sized20White,
                ),
                SizedBox(height: 32.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPTextField(
                    length: 6,
                    width: double.infinity,
                    fieldWidth: 45.w,
                    style: const TextStyle(fontSize: 15),
                    otpFieldStyle: OtpFieldStyle(
                      focusBorderColor: AppColors.primary,
                      backgroundColor: const Color(0xff121212),
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: state is OtpForgotPasswordLoading
                        ? (value) {}
                        : (value) {
                            ForgotPasswordCubit.get(context).updateOtp(value);
                          },
                  ),
                ),
                const Spacer(),
                state is OtpForgotPasswordLoading
                    ? const CustomLoadingIndicator()
                    : CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {
                          if (ForgotPasswordCubit.get(context).otp.length ==
                              6) {
                            ForgotPasswordCubit.get(context).verifyResetCode();
                          } else {
                            showTwist(
                              context: context,
                              messege: AppStrings.enterValidOtp.tr(context),
                            );
                          }
                        },
                        text: AppStrings.continuee.tr(context),
                      ),
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

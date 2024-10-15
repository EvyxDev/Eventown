import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            showTwist(
              context: context,
              messege: AppStrings.accountCreated.tr(context),
              state: ToastStates.success,
            );
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signIn, (route) => false);
          } else if (state is OtpFailed) {
            showTwist(
              context: context,
              messege: state.message,
              state: ToastStates.error,
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
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 15),
                    otpFieldStyle: OtpFieldStyle(
                      focusBorderColor: AppColors.primary,
                      backgroundColor: const Color(0xff121212),
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: state is OtpLoading
                        ? (value) {}
                        : (value) {
                            SignUpCubit.get(context).updateOtp(value);
                          },
                  ),
                ),
                const Spacer(),
                state is OtpLoading
                    ? const CustomLoadingIndicator()
                    : CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {
                          if (SignUpCubit.get(context).otp.length == 6) {
                            SignUpCubit.get(context).submitOtp();
                          } else {
                            showTwist(
                              context: context,
                              messege: AppStrings.enterValidOtp.tr(context),
                              state: ToastStates.error,
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

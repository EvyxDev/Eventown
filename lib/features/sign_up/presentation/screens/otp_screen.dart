import 'dart:async';

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

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 60;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            showTwist(
              context: context,
              messege: AppStrings.accountCreated.tr(context),
            );
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signIn, (route) => false);
          } else if (state is OtpFailed) {
            showTwist(
              context: context,
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
                SizedBox(height: 32.h),
                state is ResendCodeLoading
                    ? const CustomLoadingIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.didntReceiveCode.tr(context),
                            style: CustomTextStyle.roboto400sized14White,
                          ),
                          _start == 0
                              ? InkWell(
                                  onTap: () {
                                    SignUpCubit.get(context).reSendCode();
                                    startTimer();
                                  },
                                  child: Text(
                                    AppStrings.resendCode.tr(context),
                                    style:
                                        CustomTextStyle.roboto400sized14White,
                                  ),
                                )
                              : Text(
                                  '$_start s',
                                  style: CustomTextStyle.roboto400sized14White,
                                ),
                        ],
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

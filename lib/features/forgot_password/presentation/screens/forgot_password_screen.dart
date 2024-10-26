import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:eventown/features/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            Navigator.pushReplacementNamed(context, Routes.forgotPasswordOtp);
          } else if (state is ForgotPasswordFailed) {
            showTwist(
              context: context,
              messege: state.message,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: ForgotPasswordCubit.get(context).formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 64.h),
                  Text(
                    AppStrings.changePassword.tr(context),
                    style: CustomTextStyle.roboto700sized20White,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppStrings.typeYourRegisteredEmailToReceivePINCode
                        .tr(context),
                    style: CustomTextStyle.roboto400sized12Grey,
                  ),
                  SizedBox(height: 32.h),
                  CustomTextFormField(
                    labelText: AppStrings.email.tr(context),
                    enabled: state is! ForgotPasswordLoading,
                    controller:
                        ForgotPasswordCubit.get(context).emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return Validation.validateEmpty(value!) != null
                          ? Validation.validateEmpty(value)!.tr(context)
                          : Validation.validateEmpty(value);
                    },
                  ),
                  const Spacer(),
                  state is ForgotPasswordLoading
                      ? const CustomLoadingIndicator()
                      : CustomElevatedButton(
                          onPressed: () {
                            if (ForgotPasswordCubit.get(context)
                                .formKey
                                .currentState!
                                .validate()) {
                              ForgotPasswordCubit.get(context).sendOtp();
                            }
                          },
                          text: AppStrings.continuee.tr(context),
                          elevation: 0,
                        ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

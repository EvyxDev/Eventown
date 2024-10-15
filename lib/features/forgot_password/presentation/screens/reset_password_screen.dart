import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/utils/app_colors.dart';
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

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signIn, (route) => false);

            showTwist(
              context: context,
              messege: AppStrings.passwordChangedSuccessfully.tr(context),
              state: ToastStates.success,
            );
          } else if (state is ResetPasswordFailed) {
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
            child: Form(
              key: ForgotPasswordCubit.get(context).resetFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 64.h),
                  Text(
                    AppStrings.changePassword.tr(context),
                    style: CustomTextStyle.roboto700sized20White,
                  ),
                  SizedBox(height: 32.h),
                  CustomTextFormField(
                    obscureText:
                        ForgotPasswordCubit.get(context).isPasswordObscure,
                    suffixIcon: GestureDetector(
                      onTap: ForgotPasswordCubit.get(context).passwordObscure,
                      child: Icon(
                        ForgotPasswordCubit.get(context).isPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grey,
                      ),
                    ),
                    labelText: AppStrings.password.tr(context),
                    enabled: state is! ResetPasswordLoading,
                    controller:
                        ForgotPasswordCubit.get(context).newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      return Validation.validatePassword(value!) != null
                          ? Validation.validatePassword(value)!.tr(context)
                          : Validation.validatePassword(value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    labelText: AppStrings.confirmPassword.tr(context),
                    suffixIcon: GestureDetector(
                      onTap:
                          ForgotPasswordCubit.get(context).confPasswordObscure,
                      child: Icon(
                        ForgotPasswordCubit.get(context).isConfPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grey,
                      ),
                    ),
                    obscureText:
                        ForgotPasswordCubit.get(context).isConfPasswordObscure,
                    enabled: state is! ResetPasswordLoading,
                    controller: ForgotPasswordCubit.get(context)
                        .confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      return Validation.validateConfirmPassword(
                                  ForgotPasswordCubit.get(context)
                                      .newPasswordController
                                      .text,
                                  value!) !=
                              null
                          ? Validation.validateConfirmPassword(
                                  ForgotPasswordCubit.get(context)
                                      .newPasswordController
                                      .text,
                                  value)!
                              .tr(context)
                          : Validation.validateConfirmPassword(
                              ForgotPasswordCubit.get(context)
                                  .newPasswordController
                                  .text,
                              value);
                    },
                  ),
                  const Spacer(),
                  state is ResetPasswordLoading
                      ? const CustomLoadingIndicator()
                      : CustomElevatedButton(
                          onPressed: () {
                            if (ForgotPasswordCubit.get(context)
                                .resetFormKey
                                .currentState!
                                .validate()) {
                              ForgotPasswordCubit.get(context).resetPassword();
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

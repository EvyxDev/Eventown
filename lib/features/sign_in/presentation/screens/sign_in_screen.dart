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
import 'package:eventown/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:eventown/features/sign_in/presentation/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.homeScreen,
              (route) => false,
            );
          } else if (state is SignInFailed) {
            showTwist(
              context: context,
              messege: state.message,
              state: ToastStates.success,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: SignInCubit.get(context).formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 64.h),
                      Text(
                        AppStrings.welcome.tr(context),
                        style: CustomTextStyle.roboto400sized20Primary,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        AppStrings.signIn.tr(context),
                        style: CustomTextStyle.roboto700sized36White,
                      ),
                      SizedBox(height: 32.h),
                      CustomTextFormField(
                        controller: SignInCubit.get(context).emailController,
                        hintText: AppStrings.email.tr(context),
                        obscureText: false,
                        enabled: state is! SignInLoading,
                        validator: (value) {
                          return Validation.validateEmpty(value!) != null
                              ? Validation.validateEmpty(value)!.tr(context)
                              : Validation.validateEmpty(value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        controller: SignInCubit.get(context).passwordController,
                        hintText: AppStrings.password.tr(context),
                        enabled: state is! SignInLoading,
                        obscureText: SignInCubit.get(context).isPasswordObscure,
                        suffixIcon: GestureDetector(
                          onTap: state is SignInLoading
                              ? SignInCubit.get(context).passwordObscure
                              : null,
                          child: Icon(
                            SignInCubit.get(context).isPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.grey,
                          ),
                        ),
                        validator: (value) {
                          return Validation.validateEmpty(value!) != null
                              ? Validation.validateEmpty(value)!.tr(context)
                              : Validation.validateEmpty(value);
                        },
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: InkWell(
                          onTap: state is SignInLoading
                              ? () {}
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.forgotPassword,
                                  );
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.forgotYourPassword.tr(context),
                                style: CustomTextStyle.roboto400sized12Grey,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                AppStrings.changeItNow.tr(context),
                                style: CustomTextStyle.roboto400sized12Primary,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 200.h),
                      state is SignInLoading
                          ? const CustomLoadingIndicator()
                          : CustomElevatedButton(
                              text: AppStrings.login,
                              onPressed: () async {
                                if (SignInCubit.get(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  SignInCubit.get(context).signIn();
                                }
                              },
                              elevation: 0,
                            ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAnAccount.tr(context),
                            style: CustomTextStyle.roboto400sized14Grey,
                          ),
                          TextButton(
                            onPressed: state is SignInLoading
                                ? () {}
                                : () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.signUp,
                                    );
                                  },
                            child: Text(
                              AppStrings.registerNow.tr(context),
                              style: CustomTextStyle.roboto400sized14Primary,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

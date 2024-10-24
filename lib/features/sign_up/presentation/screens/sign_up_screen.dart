import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_drop_down_button.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_state.dart';
import 'package:eventown/features/sign_up/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.pushReplacementNamed(context, Routes.otp);
            showTwist(
              context: context,
              messege: AppStrings.pleaseConfirmYourAccount.tr(context),
              state: ToastStates.success,
            );
          } else if (state is SignUpFailed) {
            showTwist(
              context: context,
              messege: state.message,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall:
                state is SignUpLoading || state is GetAllCategoriesLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: SignUpCubit.get(context).formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 64.h),
                      Text(
                        AppStrings.welcome.tr(context),
                        style: CustomTextStyle.roboto400sized20Primary,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        AppStrings.signUp.tr(context),
                        style: CustomTextStyle.roboto700sized36White,
                      ),
                      SizedBox(height: 32.h),
                      CustomTextFormField(
                        controller: SignUpCubit.get(context).nameController,
                        enabled: state is SignUpLoading ? false : true,
                        labelText: AppStrings.fullName.tr(context),
                        validator: (value) {
                          return Validation.validateEmpty(value!) != null
                              ? Validation.validateEmpty(value)!.tr(context)
                              : Validation.validateEmpty(value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        controller: SignUpCubit.get(context).emailController,
                        labelText: AppStrings.email.tr(context),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return Validation.validateEmail(value!) != null
                              ? Validation.validateEmail(value)!.tr(context)
                              : Validation.validateEmail(value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomTextFormField(
                          controller: SignUpCubit.get(context).phoneController,
                          enabled: state is SignUpLoading ? false : true,
                          labelText: AppStrings.phoneNumber.tr(context),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            return Validation.validatePhneNumber(value!) != null
                                ? Validation.validatePhneNumber(value)!
                                    .tr(context)
                                : Validation.validatePhneNumber(value);
                          },
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                              horizontal: 16.w,
                            ),
                            child: Text(
                              "+20",
                              style: CustomTextStyle.roboto700sized14Grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomDropDownButton(
                        items: GlobalCubit.get(context)
                            .egyptGovernorates
                            .map(
                              (city) => DropdownMenuItem<String>(
                                value: city,
                                child: Text(
                                  city.tr(context),
                                  style: CustomTextStyle.roboto700sized14Grey,
                                ),
                              ),
                            )
                            .toList(),
                        label: AppStrings.city.tr(context),
                        labelStyle: CustomTextStyle.roboto700sized14Grey,
                        value: null,
                        onChanged: (value) {
                          state is SignUpLoading
                              ? null
                              : SignUpCubit.get(context)
                                  .updateCity(value.toString());
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomDropDownButton(
                        items: [
                          DropdownMenuItem<String>(
                            value: "male",
                            child: Text(
                              AppStrings.male.tr(context),
                              style: CustomTextStyle.roboto700sized14Grey,
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "female",
                            child: Text(
                              AppStrings.female.tr(context),
                              style: CustomTextStyle.roboto700sized14Grey,
                            ),
                          ),
                        ],
                        label: AppStrings.gender.tr(context),
                        labelStyle: CustomTextStyle.roboto700sized14Grey,
                        value: null,
                        onChanged: (value) {
                          state is SignUpLoading
                              ? null
                              : SignUpCubit.get(context)
                                  .updateGender(value.toString());
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        controller: SignUpCubit.get(context).passwordController,
                        labelText: AppStrings.password.tr(context),
                        obscureText: SignUpCubit.get(context).isPasswordObscure,
                        keyboardType: TextInputType.visiblePassword,
                        enabled: state is SignUpLoading ? false : true,
                        suffixIcon: GestureDetector(
                          onTap: SignUpCubit.get(context).passwordObscure,
                          child: Icon(
                            SignUpCubit.get(context).isPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.grey,
                          ),
                        ),
                        validator: (value) {
                          return Validation.validatePassword(value!) != null
                              ? Validation.validatePassword(value)!.tr(context)
                              : Validation.validatePassword(value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        controller:
                            SignUpCubit.get(context).confPasswordController,
                        labelText: AppStrings.confirmPassword.tr(context),
                        obscureText:
                            SignUpCubit.get(context).isConfPasswordObscure,
                        keyboardType: TextInputType.visiblePassword,
                        enabled: state is SignUpLoading ? false : true,
                        suffixIcon: GestureDetector(
                          onTap: SignUpCubit.get(context).confPasswordObscure,
                          child: Icon(
                            SignUpCubit.get(context).isConfPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.grey,
                          ),
                        ),
                        validator: (value) {
                          return Validation.validateConfirmPassword(
                                      SignUpCubit.get(context)
                                          .passwordController
                                          .text,
                                      value!) !=
                                  null
                              ? Validation.validateConfirmPassword(
                                      SignUpCubit.get(context)
                                          .passwordController
                                          .text,
                                      value)!
                                  .tr(context)
                              : Validation.validateConfirmPassword(
                                  SignUpCubit.get(context)
                                      .passwordController
                                      .text,
                                  value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Text(
                            AppStrings.pickYourInterests.tr(context),
                            style: CustomTextStyle.roboto400sized16Primary,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "${SignUpCubit.get(context).interests.length}/5",
                            style: CustomTextStyle.roboto400sized16Primary
                                .copyWith(
                              color:
                                  SignUpCubit.get(context).interests.length != 5
                                      ? AppColors.grey
                                      : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      // Interests
                      SignUpCubit.get(context).allCategories.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.noCategoriesFoundTryAgainLater
                                          .tr(context),
                                      style:
                                          CustomTextStyle.roboto400sized14Grey,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                // try again button
                                CustomElevatedButton(
                                  text: AppStrings.tryAgain.tr(context),
                                  elevation: 0,
                                  width: 200.w,
                                  color: AppColors.black,
                                  textColor: AppColors.grey,
                                  onPressed: () {
                                    SignUpCubit.get(context).getAllCategories();
                                  },
                                ),
                                SizedBox(height: 16.h),
                              ],
                            )
                          : Container(
                              height: 300.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 16.w,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16.h),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: SignUpCubit.get(context)
                                          .allCategories
                                          .map(
                                            (interest) =>
                                                CategoryItem(title: interest),
                                          )
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      // Terms and Conditions
                      Row(
                        children: [
                          Checkbox(
                            value: SignUpCubit.get(context).agreedToTerms,
                            onChanged: (value) {
                              state is SignUpLoading
                                  ? null
                                  : SignUpCubit.get(context)
                                      .updateAgreedToTerms();
                            },
                            checkColor: AppColors.white,
                            activeColor: AppColors.primary,
                          ),
                          Row(
                            children: [
                              Text(
                                AppStrings.iAgreeToThe.tr(context),
                                style: CustomTextStyle.roboto400sized12Grey,
                              ),
                              SizedBox(width: 6.w),
                              InkWell(
                                onTap: () {
                                  state is SignUpLoading
                                      ? null
                                      : Navigator.pushNamed(
                                          context,
                                          Routes.termsAndConditions,
                                        );
                                },
                                child: Text(
                                  AppStrings.termsAndConditions.tr(context),
                                  style:
                                      CustomTextStyle.roboto400sized12Primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Sign Up Button
                      CustomElevatedButton(
                        text: AppStrings.signUp.tr(context),
                        elevation: 0,
                        onPressed: () {
                          if (SignUpCubit.get(context)
                              .formKey
                              .currentState!
                              .validate()) {
                            if (SignUpCubit.get(context).cityController ==
                                null) {
                              showTwist(
                                context: context,
                                messege:
                                    AppStrings.pleaseSelectCity.tr(context),
                                state: ToastStates.error,
                              );
                            } else {
                              if (SignUpCubit.get(context).genderController ==
                                  null) {
                                showTwist(
                                  context: context,
                                  messege:
                                      AppStrings.pleaseSelectGender.tr(context),
                                  state: ToastStates.error,
                                );
                              } else {
                                if (SignUpCubit.get(context).interests.length !=
                                    5) {
                                  showTwist(
                                    context: context,
                                    messege: AppStrings.pleaseSelect5Interests
                                        .tr(context),
                                    state: ToastStates.error,
                                  );
                                } else {
                                  if (!SignUpCubit.get(context).agreedToTerms) {
                                    showTwist(
                                      context: context,
                                      messege: AppStrings.pleaseAgreeToTheTerms
                                          .tr(context),
                                      state: ToastStates.error,
                                    );
                                  } else {
                                    SignUpCubit.get(context).signUp();
                                  }
                                }
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Don't have an account?
                      GestureDetector(
                        onTap: () => state is SignUpLoading
                            ? null
                            : Navigator.pop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.alreadyHaveAnAccount.tr(context),
                              style: CustomTextStyle.roboto400sized14Grey,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.signIn.tr(context),
                              style: CustomTextStyle.roboto400sized14Primary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 64.h),
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

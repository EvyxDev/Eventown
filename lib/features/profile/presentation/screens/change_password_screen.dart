import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:eventown/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showTwist(
              context: context,
              messege: AppStrings.passwordChangedSuccessfully.tr(context),
              state: ToastStates.success,
            );
            sl<CacheHelper>().removeData(key: AppConstants.token);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signIn,
              (route) => false,
            );
          } else if (state is ChangePasswordError) {
            showTwist(
              context: context,
              messege: state.error,
              state: ToastStates.success,
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is ChangePasswordLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 48.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        Colors.deepOrange.shade900,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 64.r,
                            backgroundImage: GlobalCubit.get(context)
                                        .user
                                        ?.data
                                        ?.profileImg !=
                                    null
                                ? displayProviderCachedNetworkImage(
                                    imageUrl: GlobalCubit.get(context)
                                            .user
                                            ?.data
                                            ?.profileImg ??
                                        "",
                                  )
                                : const AssetImage(
                                    Assets.assetsImagesPngProfile,
                                  ),
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ],
                  ),
                ),
                Form(
                  key: ProfileCubit.get(context).formKey,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ListView(
                        children: [
                          CustomTextFormField(
                            controller:
                                ProfileCubit.get(context).oldPasswordController,
                            hintText: AppStrings.oldPassword.tr(context),
                            obscureText:
                                ProfileCubit.get(context).isOldPassordObsure,
                            suffixIcon: IconButton(
                              icon: Icon(
                                ProfileCubit.get(context).isOldPassordObsure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                              onPressed: () {
                                ProfileCubit.get(context)
                                    .changeOldPasswordObsure();
                              },
                            ),
                            validator: (value) {
                              return Validation.validateEmpty(value!) != null
                                  ? Validation.validateEmpty(value)!.tr(context)
                                  : Validation.validateEmpty(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            controller:
                                ProfileCubit.get(context).passwordController,
                            hintText: AppStrings.newPassword.tr(context),
                            obscureText:
                                ProfileCubit.get(context).isPasswordObsure,
                            suffixIcon: IconButton(
                              icon: Icon(
                                ProfileCubit.get(context).isPasswordObsure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                              onPressed: () {
                                ProfileCubit.get(context)
                                    .changePasswordObsure();
                              },
                            ),
                            validator: (value) {
                              return Validation.validatePassword(value!) != null
                                  ? Validation.validatePassword(value)!
                                      .tr(context)
                                  : Validation.validatePassword(value);
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            controller: ProfileCubit.get(context)
                                .confPasswordController,
                            hintText: AppStrings.confirmNewPassword.tr(context),
                            obscureText:
                                ProfileCubit.get(context).isConfPasswordObsure,
                            suffixIcon: IconButton(
                              icon: Icon(
                                ProfileCubit.get(context).isConfPasswordObsure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                              onPressed: () {
                                ProfileCubit.get(context)
                                    .changeConfPasswordObsure();
                              },
                            ),
                            validator: (value) {
                              return Validation.validateConfirmPassword(
                                          ProfileCubit.get(context)
                                              .passwordController
                                              .text,
                                          value!) !=
                                      null
                                  ? Validation.validateConfirmPassword(
                                          ProfileCubit.get(context)
                                              .passwordController
                                              .text,
                                          value)!
                                      .tr(context)
                                  : Validation.validateConfirmPassword(
                                      ProfileCubit.get(context)
                                          .passwordController
                                          .text,
                                      value);
                            },
                          ),
                          SizedBox(height: 32.h),
                          CustomElevatedButton(
                            text: AppStrings.changePassword.tr(context),
                            onPressed: () {
                              if (ProfileCubit.get(context)
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                ProfileCubit.get(context).changePassword();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

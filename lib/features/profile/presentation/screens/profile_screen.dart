import 'dart:io';
import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_cached_network_image.dart';
import 'package:eventown/core/widgets/custom_drop_down_button.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:eventown/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          showTwist(
            context: context,
            messege: state.error,
            state: ToastStates.error,
          );
        } else if (state is ProfileSuccess) {
          showTwist(
            context: context,
            messege: AppStrings.profileUpdatedSuccessfully.tr(context),
            state: ToastStates.success,
          );
          GlobalCubit.get(context).getUserProfile();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ProfileLoading,
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
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 64.r,
                              backgroundImage: ProfileCubit.get(context)
                                          .selectedProfileImage !=
                                      null
                                  ? FileImage(
                                      File(
                                        ProfileCubit.get(context)
                                            .selectedProfileImage!
                                            .path,
                                      ),
                                    )
                                  : GlobalCubit.get(context)
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
                            ProfileCubit.get(context).selectedProfileImage !=
                                    null
                                ? state is ProfileLoading
                                    ? const SizedBox()
                                    : Positioned(
                                        top: -12,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            ProfileCubit.get(context)
                                                .updateSelectedProfileImage(
                                                    null);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 8.h,
                                            ),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.white,
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            Positioned(
                              bottom: -12,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  state is ProfileLoading
                                      ? null
                                      : ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery)
                                          .then(
                                          (value) {
                                            if (value != null) {
                                              ProfileCubit.get(context)
                                                  .updateSelectedProfileImage(
                                                      value);
                                            }
                                          },
                                        );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: Form(
                  key: ProfileCubit.get(context).formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              labelText: AppStrings.fullName.tr(context),
                              controller:
                                  ProfileCubit.get(context).fullNameController,
                              enabled: state is ProfileLoading ? false : true,
                              validator: (value) {
                                return Validation.validateEmpty(value!) != null
                                    ? Validation.validateEmpty(value)!
                                        .tr(context)
                                    : Validation.validateEmpty(value);
                              },
                              onChanged: (p0) {
                                ProfileCubit.get(context).updateUI();
                              },
                            ),
                            SizedBox(height: 24.h),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: CustomTextFormField(
                                controller:
                                    ProfileCubit.get(context).phoneController,
                                enabled: state is ProfileLoading ? false : true,
                                labelText: AppStrings.phoneNumber.tr(context),
                                keyboardType: TextInputType.phone,
                                onChanged: (p0) {
                                  ProfileCubit.get(context).updateUI();
                                },
                                validator: (value) {
                                  return Validation.validatePhneNumber(
                                              value!) !=
                                          null
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
                                        style: CustomTextStyle
                                            .roboto700sized14Grey,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              label: AppStrings.city.tr(context),
                              labelStyle: CustomTextStyle.roboto700sized14Grey,
                              value: context
                                  .read<GlobalCubit>()
                                  .user
                                  ?.data
                                  ?.location,
                              onChanged: (value) {
                                state is ProfileLoading
                                    ? null
                                    : ProfileCubit.get(context)
                                        .updateSelectedLocation(
                                            value.toString());
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
                              value: context
                                  .read<GlobalCubit>()
                                  .user
                                  ?.data
                                  ?.gender,
                              onChanged: (value) {
                                state is ProfileLoading
                                    ? null
                                    : ProfileCubit.get(context)
                                        .updateSelectedGender(value.toString());
                              },
                            ),
                            SizedBox(height: 24.h),
                            CustomElevatedButton(
                              text: "Save Changes",
                              onPressed: ProfileCubit.get(context)
                                      .isUserDataChanged(context)
                                  ? () {
                                      // if (ProfileCubit.get(context)
                                      //     .formKey
                                      //     .currentState!
                                      //     .validate()) {
                                      //
                                      // }
                                      ProfileCubit.get(context).updateProfile();
                                    }
                                  : null,
                              elevation: 0,
                            ),
                            SizedBox(height: 24.h),
                            CustomElevatedButton(
                              text: AppStrings.changePassword.tr(context),
                              onPressed: () {},
                              elevation: 0,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}

import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/validations.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateOrganizerScreen extends StatefulWidget {
  const CreateOrganizerScreen({super.key});

  @override
  State<CreateOrganizerScreen> createState() => _CreateOrganizerScreenState();
}

class _CreateOrganizerScreenState extends State<CreateOrganizerScreen> {
  late GlobalKey<FormState> createOrganizerFormKey;
  late TextEditingController organizerNameController;
  late TextEditingController organizationNameController;
  late TextEditingController organizationFieldController;
  late TextEditingController organizationWebsiteController;
  late TextEditingController organizationPhoneNumberController;
  late TextEditingController organizationEmailController;
  late TextEditingController adviceCreateOrganizerController;

  @override
  void initState() {
    createOrganizerFormKey = GlobalKey<FormState>();
    organizerNameController = TextEditingController();
    organizationNameController = TextEditingController();
    organizationFieldController = TextEditingController();
    organizationWebsiteController = TextEditingController();
    organizationPhoneNumberController = TextEditingController();
    organizationEmailController = TextEditingController();
    adviceCreateOrganizerController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    organizerNameController.dispose();
    organizationNameController.dispose();
    organizationFieldController.dispose();
    organizationWebsiteController.dispose();
    organizationPhoneNumberController.dispose();
    organizationEmailController.dispose();
    adviceCreateOrganizerController.dispose();
    createOrganizerFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is CreateOrganizerSuccess) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SuccessScreen(
                    title: AppStrings.organizerCreatedSuccessfully.tr(context),
                    subTitle: AppStrings.organizerCreatedSuccessfullySub.tr(context),
                  );
                },
              ),
            );
          } else if (state is CreateOrganizerError) {
            showTwist(context: context, messege: state.message);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is CreateOrganizerLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: Column(
              children: [
                const CreateOrganizerAppBar(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Form(
                      key: createOrganizerFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            //!organizerName
                            CustomTextFormField(
                              labelText: AppStrings.organizerName.tr(context),
                              controller: organizerNameController,
                              validator: (value) {
                                return Validation.validateEmpty(value!) != null
                                    ? Validation.validateEmpty(value)!
                                        .tr(context)
                                    : Validation.validateEmpty(value);
                              },
                            ),
                            SizedBox(height: 16.h),
                            //!organizationName
                            CustomTextFormField(
                              labelText:
                                  AppStrings.organizationName.tr(context),
                              controller: organizationNameController,
                              validator: (value) {
                                return Validation.validateEmpty(value!) != null
                                    ? Validation.validateEmpty(value)!
                                        .tr(context)
                                    : Validation.validateEmpty(value);
                              },
                            ),
                            SizedBox(height: 16.h),
                            //!organizationField
                            CustomTextFormField(
                              labelText:
                                  AppStrings.organizationField.tr(context),
                              controller: organizationFieldController,
                              validator: (value) {
                                return Validation.validateEmpty(value!) != null
                                    ? Validation.validateEmpty(value)!
                                        .tr(context)
                                    : Validation.validateEmpty(value);
                              },
                            ),
                            SizedBox(height: 16.h),
                            //! organizationPhoneNumber
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: CustomTextFormField(
                                controller: organizationPhoneNumberController,
                                labelText: AppStrings.organizationPhoneNumber
                                    .tr(context),
                                keyboardType: TextInputType.phone,
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
                            SizedBox(height: 16.h),
                            //! organizationEmail
                            CustomTextFormField(
                              labelText:
                                  AppStrings.organizationEmail.tr(context),
                              controller: organizationEmailController,
                              validator: (value) {
                                return Validation.validateEmail(value!) != null
                                    ? Validation.validateEmail(value)!
                                        .tr(context)
                                    : Validation.validateEmail(value);
                              },
                            ),
                            SizedBox(height: 16.h),
                            //! organizationWebsite
                            CustomTextFormField(
                              labelText:
                                  AppStrings.organizationWebsite.tr(context),
                              controller: organizationWebsiteController,
                              validator: (value) {
                                return Validation.validateWebsite(value!) !=
                                        null
                                    ? Validation.validateWebsite(value)!
                                        .tr(context)
                                    : Validation.validateWebsite(value);
                              },
                            ),
                            SizedBox(height: 16.h),

                            //! OrganizerAdvice
                            CustomTextFormField(
                              hintText: AppStrings.advice.tr(context),
                              maxLines: 5,
                              controller: adviceCreateOrganizerController,
                              validator: (value) {
                                return Validation.validateEmpty(value!) != null
                                    ? Validation.validateEmpty(value)!
                                        .tr(context)
                                    : Validation.validateEmpty(value);
                              },
                            ),
                            SizedBox(height: 32.h),
                            //! *******************************************************************
                            CustomElevatedButton(
                              text: AppStrings.createOrganizer.tr(context),
                              onPressed: () {
                                if (createOrganizerFormKey.currentState!
                                    .validate()) {
                                  HomeCubit.get(context).createOrganizer(
                                    organizerName:
                                        organizerNameController.text.trim(),
                                    organizationName:
                                        organizationNameController.text.trim(),
                                    organizationField:
                                        organizationFieldController.text.trim(),
                                    organizationPhoneNumber:
                                        organizationPhoneNumberController.text
                                            .trim(),
                                    organizationEmail:
                                        organizationEmailController.text.trim(),
                                    organizationWebsite:
                                        organizationWebsiteController.text
                                            .trim(),
                                    adviceCreateOrganizer:
                                        adviceCreateOrganizerController.text
                                            .trim(),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 64.h),
                          ],
                        ),
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

class CreateOrganizerAppBar extends StatelessWidget {
  const CreateOrganizerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Colors.deepOrange.shade800,
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
          Text(
            AppStrings.createOrganizer.tr(context),
            style: CustomTextStyle.roboto700sized20White,
          ),
        ],
      ),
    );
  }
}

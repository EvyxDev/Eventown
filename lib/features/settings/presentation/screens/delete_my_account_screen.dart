import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/routes/app_routes.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_elevated_button.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DeleteMyAccountScreen extends StatelessWidget {
  const DeleteMyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteMyAccountError) {
            showTwist(context: context, messege: state.message);
          } else if (state is DeleteMyAccountSuccess) {
            showTwist(
              context: context,
              messege: AppStrings.accountDeletedSuccessfully.tr(context),
            );
            context.read<GlobalCubit>().changeBottom(0);
            sl<CacheHelper>().removeData(key: AppConstants.token);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signIn,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is DeleteMyAccountLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.areYouSureYouWantToDeleteYourAccount
                          .tr(context),
                      style: CustomTextStyle.roboto700sized20White,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: AppStrings.deleteMyAccount.tr(context),
                      onPressed: () {
                        context.read<HomeCubit>().deleteMyAccount();
                      },
                      color: Colors.red,
                      borderColor: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

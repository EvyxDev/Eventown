import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/categories_in_home_section.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:eventown/features/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(context),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is HomeLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    CategoriesInHomeSection(
                      homeCategories: context.read<HomeCubit>().homeCategories,
                    ),
                    SizedBox(height: 16.h),
                    CategoriesSection(title: AppStrings.topEvents.tr(context)),
                    SizedBox(height: 16.h),
                    CategoriesSection(
                        title: AppStrings.onThisWeekEvents.tr(context)),
                    SizedBox(height: 16.h),
                    CategoriesSection(
                        title: AppStrings.forYouEvents.tr(context)),
                    SizedBox(height: 16.h),
                    CategoriesSection(
                        title: AppStrings.inYourAreaEvents.tr(context)),
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

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: CustomTextStyle.roboto700sized20White,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.viewAll.tr(context),
              ),
            )
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const EventCard();
            },
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemCount: 5,
          ),
        )
      ],
    );
  }
}

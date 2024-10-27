import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getWishlistEvents(isLoading: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is GetUserWishListLoading,
            progressIndicator: const CustomLoadingIndicator(),
            color: Colors.transparent,
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
                        AppStrings.favorite.tr(context),
                        style: CustomTextStyle.roboto700sized20White,
                      ),
                    ],
                  ),
                ),
                state is GetUserWishListLoading
                    ? const SizedBox()
                    : Expanded(
                        child: context.read<HomeCubit>().wishListEvents.isEmpty
                            ? Center(
                                child:
                                    Text(AppStrings.noEventsFound.tr(context)),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: RefreshIndicator(
                                  backgroundColor: AppColors.white,
                                  onRefresh: () {
                                    return context
                                        .read<HomeCubit>()
                                        .getWishlistEvents(isLoading: true);
                                  },
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 255.h,
                                        child: EventCard(
                                          event: context
                                              .read<HomeCubit>()
                                              .wishListEvents[index],
                                        ),
                                      );
                                    },
                                    itemCount: context
                                        .read<HomeCubit>()
                                        .wishListEvents
                                        .length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16.h),
                                  ),
                                ),
                              ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

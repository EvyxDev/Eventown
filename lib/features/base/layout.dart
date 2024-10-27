import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            if (cubit.currentIndex != 0) {
              cubit.changeBottom(0);
              return false; // Prevent app from closing
            }
            return true; // Allow app to close
          },
          child: ModalProgressHUD(
            inAsyncCall: state is HomeLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: BlocBuilder<GlobalCubit, GlobalState>(
              builder: (context, state) {
                return Scaffold(
                  extendBody: false,
                  body: cubit.bottomScreens[cubit.currentIndex],
                  bottomNavigationBar: CrystalNavigationBar(
                    backgroundColor: AppColors.black,
                    unselectedItemColor: AppColors.primary,
                    selectedItemColor: AppColors.primary,
                    onTap: (index) {
                      cubit.changeBottom(index);
                    },
                    currentIndex: cubit.currentIndex,
                    items: [
                      /// Home
                      CrystalNavigationBarItem(
                        icon: IconlyBold.home,
                        unselectedIcon: IconlyLight.home,
                        selectedColor: AppColors.primary,
                      ),

                      /// Fav
                      CrystalNavigationBarItem(
                        icon: IconlyBold.heart,
                        unselectedIcon: IconlyLight.heart,
                        selectedColor: AppColors.primary,
                      ),

                      /// Game
                      CrystalNavigationBarItem(
                        icon: IconlyBold.game,
                        unselectedIcon: IconlyLight.game,
                        selectedColor: AppColors.primary,
                      ),

                      /// Notification
                      CrystalNavigationBarItem(
                        icon: IconlyBold.notification,
                        unselectedIcon: IconlyLight.notification,
                        selectedColor: AppColors.primary,
                      ),

                      /// Profile
                      CrystalNavigationBarItem(
                        icon: IconlyBold.user_3,
                        unselectedIcon: IconlyLight.user,
                        selectedColor: AppColors.primary,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

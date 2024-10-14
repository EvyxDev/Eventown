import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
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
              /// Favourite
              CrystalNavigationBarItem(
                icon: IconlyBold.game,
                unselectedIcon: IconlyLight.game,
                selectedColor: AppColors.primary,
              ),
              /// Add
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
    );
  }
}

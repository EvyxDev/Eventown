import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/cubit/global_state.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyBold.home),
        title: ("Home"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyBold.game),
        title: ("game"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyBold.notification),
        title: ("notification"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(IconlyBold.user_3),
        title: ("user_3"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

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
                  body: PersistentTabView(
                    context,
                    controller: context.read<GlobalCubit>().controller,
                    screens: context.read<GlobalCubit>().bottomScreens,
                    items: _navBarsItems(),
                    handleAndroidBackButtonPress: true,
                    resizeToAvoidBottomInset: true,
                    stateManagement: true,
                    hideNavigationBarWhenKeyboardAppears: true,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      right: 8,
                      left: 8,
                    ),
                    backgroundColor: AppColors.black,
                    isVisible: true,
                    animationSettings: const NavBarAnimationSettings(
                      navBarItemAnimation: ItemAnimationSettings(
                        // Navigation Bar's items animation properties.
                        duration: Duration(milliseconds: 400),
                        curve: Curves.ease,
                      ),
                    ),
                    confineToSafeArea: true,
                    navBarHeight: kBottomNavigationBarHeight,
                    navBarStyle: NavBarStyle.style13,
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

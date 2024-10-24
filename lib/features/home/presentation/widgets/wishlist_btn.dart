import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class WishlistBtn extends StatelessWidget {
  const WishlistBtn({
    super.key,
    required this.event,
    this.size,
  });
  final EventModel event;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // if (state is AddEventToWhishlistFailed) {
        //   showTwist(
        //     context: context,
        //     messege: AppStrings.couldNotAddToWishList.tr(context),
        //     state: ToastStates.error,
        //     toastLength: Toast.LENGTH_SHORT,
        //   );
        // } else if (state is RemoveEventToWhishlistFailed) {
        //   showTwist(
        //     context: context,
        //     messege: AppStrings.couldNotRemoveFromWishList.tr(context),
        //     state: ToastStates.error,
        //     toastLength: Toast.LENGTH_SHORT,
        //   );
        // } else if (state is AddEventToWhishlistSuccess) {
        //   showTwist(
        //     context: context,
        //     messege: AppStrings.addedToWishList.tr(context),
        //     state: ToastStates.success,
        //     toastLength: Toast.LENGTH_SHORT,
        //   );
        // } else if (state is RemoveEventToWhishlistSuccess) {
        //   showTwist(
        //     context: context,
        //     messege: AppStrings.removedFromWishList.tr(context),
        //     state: ToastStates.success,
        //     toastLength: Toast.LENGTH_SHORT,
        //   );
        // }
      },
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            if (context.read<HomeCubit>().isEventInWishlist(event.id ?? "")) {
              context
                  .read<HomeCubit>()
                  .removeEventFromWishlist(eventId: "${event.id}");
            } else {
              context
                  .read<HomeCubit>()
                  .addEventToWishlist(eventId: "${event.id}");
            }
            // toggle();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              context.read<HomeCubit>().isEventInWishlist(event.id ?? "")
                  ? Icons.favorite
                  : IconlyLight.heart,
              size: size ?? 18,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}

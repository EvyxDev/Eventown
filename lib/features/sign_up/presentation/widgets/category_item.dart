import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:eventown/features/sign_up/presentation/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title});
  final Category title;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return FilterChip(
          label: Text(
            title.title ?? "",
          ),
          selected: SignUpCubit.get(context).isCategorySelected(title.id ?? ""),
          color: WidgetStatePropertyAll(
              SignUpCubit.get(context).isCategorySelected(title.id ?? "")
                  ? AppColors.primary
                  : AppColors.black),
          onSelected: (bool value) {
            state is SignUpLoading
                ? null
                : SignUpCubit.get(context)
                    .updateInterest(context, title.id ?? "");
          },
        );
      },
    );
  }
}

import 'dart:io';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadEventImage extends StatelessWidget {
  const UploadEventImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            ImagePicker()
                .pickImage(
              source: ImageSource.gallery,
            )
                .then(
              (value) {
                if (value != null) {
                  HomeCubit.get(context).updateEventImage(value);
                }
              },
            );
          },
          child: Container(
            width: double.infinity,
            height: 255.h,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.primary,
              ),
              image: HomeCubit.get(context).eventImage == null
                  ? null
                  : DecorationImage(
                      image: FileImage(
                        File(HomeCubit.get(context).eventImage!.path),
                      ),
                      fit: BoxFit.fill,
                    ),
            ),
            child: HomeCubit.get(context).eventImage != null
                ? null
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        size: 48,
                        color: AppColors.grey,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppStrings.uploadEventImage.tr(context),
                        style: CustomTextStyle.roboto700sized14Grey,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

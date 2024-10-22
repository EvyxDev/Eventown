import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

displayCachedNetworkImage({
  required String imageUrl,
  BoxFit? fit,
  double? height,
  double? width,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit ?? BoxFit.fill,
    placeholder: (context, url) => const CustomLoadingIndicator(),
    errorWidget: (context, url, error) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 50.w),
      ],
    ),
    height: height,
    width: width ?? double.infinity,
  );
}

displayProviderCachedNetworkImage({
  required String imageUrl,
}) {
  return CachedNetworkImageProvider(
    imageUrl,
  );
}

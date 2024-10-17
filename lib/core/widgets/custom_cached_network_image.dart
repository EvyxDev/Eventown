import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventown/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

displayCachedNetworkImage({
  required String imageUrl,
  BoxFit? fit,
  double? height,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit ?? BoxFit.fill,
    placeholder: (context, url) => const CustomLoadingIndicator(),
    height: height,
  );
}

displayProviderCachedNetworkImage({
  required String imageUrl,
}) {
  return CachedNetworkImageProvider(
    imageUrl,
  );
}

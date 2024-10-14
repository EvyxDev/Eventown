import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

AppBar customAppBar(BuildContext context, String title,
    {PreferredSizeWidget? bottom}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: CustomTextStyle.roboto500sized18White,
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    bottom: bottom,
  );
}

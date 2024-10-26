import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType

void navigate({
  required BuildContext context,
  required String route,
  Object? arguments,
  Function(dynamic value)? onNavigateComplete,
}) {
  Navigator.pushNamed(
    context,
    route,
    arguments: arguments,
  ).then((value) {
    if (onNavigateComplete != null) {
      onNavigateComplete(value);
    }
  });
}

void navigateReplacement({
  required BuildContext context,
  required String route,
}) {
  Navigator.pushReplacementNamed(context, route);
}

void navigatepushNamedAndRemoveUntil(
    {required BuildContext context, required String route}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    (Route<dynamic> route) => false,
  );
}

void navigatePop({required BuildContext context}) {
  Navigator.pop(context);
}

String? displayDate(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMM').format(dateTime);
}

String convertTime(DateTime? date) {
  if (date == null) {
    return '--:--';
  }
  return DateFormat('hh:mm a').format(date);
}

showExpandedBottomSheet(
  context, {
  // required List<Widget> children,
  required SliverChildDelegate Function(BuildContext, double) bodyBuilder,
  Widget? header,
  double? minHeight,
  double? initHeight,
  double? maxHeight,
  double? headerHeight,
  bool? isExpand,
  bool? isDismissible,
  bool? isCollapsible,
}) {
  showStickyFlexibleBottomSheet(
    context: context,
    minHeight: minHeight ?? 0,
    initHeight: initHeight ?? 0.5,
    maxHeight: maxHeight ?? 0.5,
    headerHeight: headerHeight ?? 0.25,
    keyboardBarrierColor: Colors.transparent,
    isCollapsible: isCollapsible ?? false,
    isDismissible: isDismissible ?? false,
    isExpand: isExpand ?? false,
    isSafeArea: true,
    isModal: true,
    bottomSheetBorderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.r),
      topRight: Radius.circular(20.r),
    ),
    headerBuilder: (BuildContext context, double offset) {
      return header ?? const SizedBox();
    },
    bodyBuilder: bodyBuilder,
  );
}

showFixedBottomSheet(
  BuildContext context, {
  required Widget Function(BuildContext, ScrollController, double) builder,
  double? minHeight,
  double? initHeight,
  double? maxHeight,
  bool? isDismissible,
  bool? isCollapsible,
  bool? isExpand,
}) {
  showFlexibleBottomSheet(
    context: context,
    minHeight: minHeight ?? 0,
    initHeight: initHeight ?? 0.4,
    maxHeight: maxHeight ?? 0.4,
    isExpand: isExpand ?? false,
    isDismissible: isDismissible ?? false,
    isCollapsible: isCollapsible ?? false,
    bottomSheetBorderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.r),
      topRight: Radius.circular(20.r),
    ),
    builder: builder,
  );
}

Future launchCustomUrl(context, String? url) async {
  if (url != null) {
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }
}

class CustomSnackbar {
  static void show(BuildContext context, String message, {IconData? icon}) {
    final overlay = Overlay.of(context);
    late OverlayEntry
        overlayEntry; // Declare overlayEntry as late to initialize it after it's built

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Dismissible(
            key: const ValueKey("dismiss_snackbar"),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              overlayEntry.remove(); // Now overlayEntry is correctly referenced
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: Colors.white, size: 26),
                  if (icon != null) const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Automatically remove after 3 seconds if not swiped
    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

void showTwist({
  required BuildContext context,
  required String messege,
}) {
  CustomSnackbar.show(
    context,
    messege,
  );
}

enum ToastStates {
  error,
  success,
  warning,
}

Future<MultipartFile> uploadImageToAPI(XFile image) async {
  // Get the mime type of the file
  String? mimeType = lookupMimeType(image.path);

  return MultipartFile.fromFile(
    image.path,
    filename: image.path.split('/').last,
    contentType: MediaType.parse(
        mimeType ?? 'image/jpeg'), // defaulting to image/jpeg if not found
  );
}

Color getState(BuildContext context, ToastStates state) {
  switch (state) {
    case ToastStates.error:
      return Colors.red;
    case ToastStates.success:
      return AppColors.primary;
    case ToastStates.warning:
      return Colors.orange;
  }
}

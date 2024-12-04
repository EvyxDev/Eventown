import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType

String? displayDate(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String? displayDateAndTime(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }
  return DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
}

// String? formatTimeOfDay(TimeOfDay? timeOfDay) {
//   if (timeOfDay != null) {
//     final hours = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
//     final minutes = timeOfDay.minute.toString().padLeft(2, '0');
//     final period = timeOfDay.period == DayPeriod.am ? "AM" : "PM";
//     return "$hours:$minutes $period";
//   }
//   return null;
// }

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

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  return List.generate(
      length, (index) => characters[random.nextInt(characters.length)]).join();
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

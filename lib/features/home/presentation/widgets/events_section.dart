import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/presentation/cubit/home_cubit.dart';
import 'package:eventown/features/home/presentation/screens/view_all_screen.dart';
import 'package:eventown/features/home/presentation/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({
    super.key,
    required this.title,
    required this.events,
    required this.eventsType,
  });
  final String title;
  final List<EventModel> events;
  final EventsType eventsType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: CustomTextStyle.roboto700sized20White,
            ),
            TextButton(
              onPressed: () {
                context.read<HomeCubit>().getViewAllEvents(type: eventsType);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewAllScreen(
                    eventsType: eventsType,
                  );
                }));
              },
              child: Text(
                AppStrings.viewAll.tr(context),
              ),
            )
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 225.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return EventCard(
                event: events[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemCount: events.length,
          ),
        )
      ],
    );
  }
}

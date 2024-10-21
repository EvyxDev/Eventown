import 'dart:async';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/features/wheel/presentation/widgets/gradient_progress_indicator.dart';
import 'package:eventown/features/wheel/presentation/widgets/review_card_image.dart';
import 'package:eventown/features/wheel/presentation/widgets/spin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen> {
  late int rewards;
  int total = 1000;
  late BehaviorSubject<int> selected;
  late DateTime lastSpinTime;
  late Timer timer;
  final List<int> items = [10, 25, 50, 75, 100, 150, 200];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    selected = BehaviorSubject<int>();
    rewards = 50;
    _loadScore();
    lastSpinTime = DateTime.now();
    _loadLastSpinTime();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    selected.close();
    timer.cancel();
    super.dispose();
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  void _scrollToStart() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  void scrollToAppropriatePosition() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (_scrollController.hasClients) {
          if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent) {
            _scrollToStart();
          } else if (_scrollController.offset <=
              _scrollController.position.minScrollExtent) {
            _scrollToEnd();
          }
        }
      },
    );
  }

  Future<void> _loadLastSpinTime() async {
    setState(() {
      lastSpinTime = DateTime.fromMillisecondsSinceEpoch(
          sl<CacheHelper>().getData(key: "last_spin_time") ?? 0);
    });
  }

  Future<void> _saveScore(int newScore) async {
    await sl<CacheHelper>().saveData(key: 'rewards', value: newScore);
  }

  Future<void> _redeemTicket() async {
    final currentRewards =
        await sl<CacheHelper>().getData(key: 'rewards') ?? 1000;
    await sl<CacheHelper>()
        .saveData(key: 'rewards', value: currentRewards - 1000);
  }

  Future<void> _loadScore() async {
    setState(() {
      rewards = sl<CacheHelper>().getData(key: "rewards") ?? 0;
    });
  }

  Future<void> _saveLastSpinTime() async {
    await sl<CacheHelper>().saveData(
        key: 'last_spin_time', value: lastSpinTime.millisecondsSinceEpoch);
  }

  // Remaining time calculation method
  Duration getRemainingTime() {
    final timeSinceLastSpin = DateTime.now().difference(lastSpinTime);
    final remainingTime = const Duration(seconds: 5) - timeSinceLastSpin;
    return remainingTime.isNegative ? Duration.zero : remainingTime;
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = getRemainingTime();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Align(
                child: Text(
                  AppStrings.welcomeToSpinAndWin.tr(context),
                  style: CustomTextStyle.roboto400sized20Primary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "${AppStrings.aboutSpinAndWin.tr(context)} :",
                style: CustomTextStyle.roboto500sized14Primary,
              ),
              SizedBox(height: 4.h),
              Text(
                AppStrings
                    .earnEverydayachancetowinafreeeventticketcollectpointsnowafterspinngthewheel
                    .tr(context),
                style: CustomTextStyle.roboto400sized14Grey,
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 16.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppStrings.howToPlaySpinAndWin.tr(context)} : ",
                    style: CustomTextStyle.roboto500sized14Primary,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings.spinAndWinInstructions.tr(context),
                    style: CustomTextStyle.roboto400sized14Grey,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Center(
                  child: progressIndicatorWithPoints(rewards / total, context)),
              SizedBox(height: 24.h),
              buildFortuneWheel(),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                      child:
                          spinButton(remainingTime, selected, items, context)),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (_) => Ticket_History_Screen(),
                        //     ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            AppStrings.ticketHistory.tr(context),
                            style: CustomTextStyle.roboto400sized14White,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              const Divider(color: AppColors.primary, thickness: 1),
              SizedBox(height: 24.h),
              Text(
                AppStrings.redeemButtonActivation.tr(context),
                style: CustomTextStyle.roboto700sized20Primary,
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {
                  if (rewards >= 1000) {
                    setState(() {
                      _redeemTicket();
                      _loadScore();
                      _saveLastSpinTime();
                      lastSpinTime = DateTime.now();
                    });
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            rewards >= 1000 ? AppColors.primary : Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: rewards >= 1000 ? AppColors.primary : Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.redeemTicket.tr(context),
                      style: CustomTextStyle.roboto400sized14White,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppStrings.howToRedeemYourTicket.tr(context)} :",
                    style: CustomTextStyle.roboto500sized14Primary,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings.redeemTicketInstructions.tr(context),
                    style: CustomTextStyle.roboto400sized14Grey,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              const Divider(color: AppColors.primary, thickness: 1),
              SizedBox(height: 24.h),
              Text(
                AppStrings.joinOurGreatEvents.tr(context),
                style: CustomTextStyle.roboto700sized20Primary,
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 24.h),
              Text("${AppStrings.previousWinners.tr(context)}: ",
                  style: CustomTextStyle.roboto400sized20Primary),
              SizedBox(height: 4.h),
              Column(
                children: List.generate(
                  4,
                  (index) {
                    return const ReviewCardGame(
                      title: "How to use Walsops application for free",
                      content:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      userName: "Ahmed Hamdy",
                      timeAgo: "2 days ago",
                      eventName: 'Al Ahly Match',
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFortuneWheel() {
    return SizedBox(
      height: 300.h,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 20,
            ),
          ],
        ),
        child: FortuneWheel(
          selected: selected.stream,
          indicators: <FortuneIndicator>[
            FortuneIndicator(
              alignment: Alignment
                  .topCenter, // <-- changing the position of the indicator
              child: TriangleIndicator(
                color: AppColors
                    .primary, // <-- changing the color of the indicator
                width: 20.w, // <-- changing the width of the indicator
                height: 20.h, // <-- changing the height of the indicator
                elevation: 4, // <-- changing the elevation of the indicator
              ),
            ),
          ],
          onAnimationEnd: () {
            if (selected.hasValue) {
              final int rewardValue = items[selected.value];
              // showDialogAndPlaySound(rewardValue);
              setState(() {
                rewards += rewardValue;
                _saveScore(rewards);
                _saveLastSpinTime();
                lastSpinTime = DateTime.now();
              });
            }
          },
          items: [
            for (var item in items)
              FortuneItem(
                style: FortuneItemStyle(
                    color: Colors.orange.shade900,
                    borderColor: Colors.orange.shade600),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: const SizedBox(),
                      ),
                      Text(
                        item.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

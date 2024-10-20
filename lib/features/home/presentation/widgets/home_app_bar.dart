import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_assets.dart';
import 'package:eventown/core/utils/app_colors.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/core/utils/app_text_styles.dart';
import 'package:eventown/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

AppBar getHomeAppBar(BuildContext context) {
  return AppBar(
    leadingWidth: 170.w,
    actions: [
      TextButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) {
          //     return WelcomeOrganizerScreen();
          //   },
          // ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                const Icon(
                  IconlyBold.plus,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                Text(
                  AppStrings.createEvent.tr(context),
                  style: CustomTextStyle.roboto400sized14White,
                ),
              ],
            ),
          ),
        ),
      )
    ],
    leading: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.assetsImagesSvgIconPlaceholder,
            width: 36.w,
            height: 36.h,
          ),
          SizedBox(width: 8.w),
          Text(
            AppStrings.appName.tr(context),
            style: CustomTextStyle.roboto700sized20White,
          ),
        ],
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            Colors.deepOrange.shade800,
          ],
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 8.w),
            Expanded(
              child: CustomTextFormField(
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                borderColor: AppColors.white,
                borderRadius: 8.r,
                style: CustomTextStyle.roboto700sized12Grey,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey,
                ),
                hintText: AppStrings.search.tr(context),
                hintStyle: CustomTextStyle.roboto700sized12Grey,
                onFieldSubmitted: (value) {
                  // context
                  //     .read<HomeBloc>()
                  //     .add(SearchEvents(keyword: value));
                },
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: InkWell(
                onTap: () {
                  // _onFilterIconPressed(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
                  child: SvgPicture.asset(
                    Assets.assetsImagesSvgFilter,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    ),
  );
}

// String? selectedDropdownValue = 'Party';
// DateTime? selectedDate = DateTime.now();

// int selectedItemIndex = -1;
// final List<Map<String, String>> categories = [
//   {'image': 'assets/images/music.png', 'label': 'MUSIC'},
//   {'image': 'assets/images/tech.png', 'label': 'EDUCATION'},
//   {'image': 'assets/images/business.png', 'label': 'TRAVEL'},
// ];
// List<String> cities = ['Cairo', 'Alex', 'Giza', 'Aswan', 'Luxor', 'Ismailia'];
// List<String> filterCategories = [
//   'MUSIC',
//   'EDUCATION',
//   'TRAVEL',
//   'TECH',
//   'SPORT'
// ];
// // create
// DateTimeRange dateRange =
//     DateTimeRange(start: DateTime.now(), end: DateTime.now());
// String? selectedCity;
// String? selectedFilterCategory;
// final ScrollController scrollController = ScrollController();
// final TextEditingController searchController = TextEditingController();

// final List<Map<String, dynamic>> sortingOptions = [
//   {'title': 'Price (Low to High)', 'value': 0.2, 'isSelected': false},
// ];
// DateTime _startDate = DateTime.now();
// DateTime _endDate = DateTime.now().add(const Duration(days: 7));

// Widget _buildDateRangeField(context) {
//   String formattedStartDate = DateFormat('MMM dd').format(_startDate);
//   String formattedEndDate = DateFormat('MMM dd').format(_endDate);
//   String dateRangeText = _startDate == _endDate
//       ? formattedStartDate
//       : '$formattedStartDate - $formattedEndDate';

//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: GestureDetector(
//       onTap: () async {
//         try {
//           final DateTime now = DateTime.now();
//           final DateTime firstDayOfMonth = DateTime.now();
//           final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

//           final DateTimeRange? pickedRange = await showDateRangePicker(
//             context: context,
//             initialDateRange: dateRange,
//             firstDate: firstDayOfMonth,
//             lastDate: lastDayOfMonth,
//             builder: (context, child) {
//               return Theme(
//                 data: ThemeData.dark().copyWith(
//                   colorScheme: ColorScheme.dark(
//                     primary: AppColors.primary,
//                     onPrimary: Colors.white,
//                     // secondary: kSecondaryColor,
//                     surface: Colors.black,
//                   ),
//                   dialogBackgroundColor: Colors.grey[900],
//                 ),
//                 child: child!,
//               );
//             },
//           );
//           if (pickedRange != null) {
//             // setState(() {
//             _startDate = pickedRange.start;
//             _endDate = pickedRange.end;
//             // });
//           }
//         } catch (error) {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('Error'),
//                 content: Text('An error occurred. Please try again.'),
//                 actions: [
//                   TextButton(
//                     child: Text('OK'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             dateRangeText.isEmpty ? 'Select Date' : dateRangeText,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Icon(
//             Icons.calendar_today,
//             color: AppColors.primary,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Future<void> _showBottomSheet(BuildContext context) async {
//   // final localizations = S.of(context);

//   await showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         height: 700,
//         decoration: BoxDecoration(
//             color: AppColors.black,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             )),
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: 30,
//               height: 5,
//               decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: BorderRadius.circular(5)),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: Text(
//                 "filter",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     child: Text(
//                       "event_category",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Center(
//                     child: Container(
//                       width: 360,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                           child: DropdownButtonFormField<String>(
//                             decoration: InputDecoration(
//                               hintText: "event_category",
//                               hintStyle: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                               border: UnderlineInputBorder(
//                                   borderSide: BorderSide.none),
//                             ),
//                             value: selectedFilterCategory,
//                             style: TextStyle(
//                               color: AppColors.primary,
//                             ),
//                             items: filterCategories
//                                 .map((cat) => DropdownMenuItem(
//                                       value: cat,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: Text(cat),
//                                       ),
//                                     ))
//                                 .toList(),
//                             onChanged: (newValue) {
//                               // setState(() {
//                               selectedCity = newValue;
//                               // });
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     child: Text(
//                       "date_range",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Center(
//                     child: Container(
//                       width: 360,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: _buildDateRangeField(context),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: sortingOptions.length,
//                       itemBuilder: (context, index) {
//                         return CheckboxListTile(
//                           title: Text(sortingOptions[index]['title']),
//                           value: sortingOptions[index]['isSelected'],
//                           onChanged: (value) {
//                             // setState(() {
//                             sortingOptions.forEach(
//                                 (option) => option['isSelected'] = false);
//                             sortingOptions[index]['isSelected'] = true;
//                             // });
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                           child: Container(
//                         height: 35,
//                         width: 120,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(color: AppColors.primary),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "cancel",
//                           ),
//                         ),
//                       )),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       GestureDetector(
//                           child: Container(
//                         height: 35,
//                         width: 120,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: AppColors.primary,
//                         ),
//                         child: Center(
//                           child: Text(
//                             "apply",
//                           ),
//                         ),
//                       )),
//                     ],
//                   )
//                 ])
//           ],
//         ),
//       );
//     },
//   );
// }

// void _onFilterIconPressed(BuildContext context) {
//   _showBottomSheet(context);
// }

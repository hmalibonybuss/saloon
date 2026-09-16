import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/home/search_screen_artist_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/booking_finalize_screen.dart';
import 'package:saloon_app/view/home/home_common_widgets/home_common_widgets.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<Map> monthList = [
    {
      "monthName": "Jan",
      "month": 1,
      "days": 31,
    },
    {
      "monthName": "Feb",
      "month": 2,
      "days": 28,
    },
    {
      "monthName": "Mar",
      "month": 3,
      "days": 31,
    },
    {
      "monthName": "Apr",
      "month": 4,
      "days": 30,
    },
    {
      "monthName": "May",
      "month": 5,
      "days": 31,
    },
    {
      "monthName": "Jun",
      "month": 6,
      "days": 30,
    },
    {
      "monthName": "Jul",
      "month": 7,
      "days": 31,
    },
    {
      "monthName": "Aug",
      "month": 8,
      "days": 31,
    },
    {
      "monthName": "Sep",
      "month": 9,
      "days": 30,
    },
    {
      "monthName": "Oct",
      "month": 10,
      "days": 31,
    },
    {
      "monthName": "Nov",
      "month": 11,
      "days": 30,
    },
    {
      "monthName": "Dec",
      "month": 12,
      "days": 31,
    },
  ];

  final List<Map> dayList = [
    {
      "dayName": "Sun",
      "day": 1,
    },
    {
      "dayName": "Mon",
      "day": 2,
    },
    {
      "dayName": "Tue",
      "day": 3,
    },
    {
      "dayName": "Wed",
      "day": 4,
    },
    {
      "dayName": "Thu",
      "day": 5,
    },
    {
      "dayName": "Fri",
      "day": 6,
    },
    {
      "dayName": "Sat",
      "day": 7,
    },
  ];

  List<SearchScreenArtistModel> detailsScreenList = [
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenLilyPng,
      name: "Lily",
      job: "Hair Stylist",
      isSelected: true,
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenLeePng,
      name: "Lee",
      job: "Sx Barber",
      isSelected: false,
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenConnorPng,
      name: "Connor",
      job: "Makeup Artist",
      isSelected: false,
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenJasonPng,
      name: "Jason",
      job: "Hair Stylist",
      isSelected: false,
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenMikePng,
      name: "Mike",
      job: "Sx Barber",
      isSelected: false,
    ),
  ];

  dynamic selectedMonth;
  List<Map> daysList = [];

  List<Map> _getDateFromMonth(int month) {
    int totalDaysInMonth = monthList[month - 1]['days'];
    List<Map> daysList = [];
    int firstDay = 1;
    for (int i = 1; i <= totalDaysInMonth; i++) {
      if (firstDay == 7) {
        daysList.add({
          "day": dayList[firstDay - 1]['dayName'],
          "date": i,
          "isSelected": false,
        });
        firstDay = 1;
      } else {
        daysList.add({
          "day": dayList[firstDay - 1]['dayName'],
          "date": i,
          "isSelected": false,
        });
        firstDay++;
      }
    }
    return daysList;
  }

  @override
  void initState() {
    selectedMonth = 1;

    daysList = _getDateFromMonth(selectedMonth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Scaffold(
            backgroundColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Book Appointment',
                    style: FontStyleUtilities.h3(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      fontWeight: FWT.semiBold,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Date',
                        style: FontStyleUtilities.h5(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                      Spacer(),
                      CustomDropDown(
                        items: monthList
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(
                                  e['monthName'],
                                  style: FontStyleUtilities.t2(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.text_300
                                        : ColorUtilities.text_300,
                                  ),
                                ),
                                value: e['month'],
                              ),
                            )
                            .toList(),
                        hint: "Month",
                        isExpanded: false,
                        isFlat: true,
                        onChange: (dynamic value) {
                          setState(() {
                            selectedMonth = value;
                          });
                          daysList = _getDateFromMonth(value);
                        },
                        selectedValue: selectedMonth,
                      ),
                    ],
                  ),
                ),
                _getDateTimePicker(),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Select Time',
                    style: FontStyleUtilities.h5(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      fontWeight: FWT.semiBold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '11:00',
                    style: FontStyleUtilities.h5(
                      fontColor: ColorUtilities.primary_500,
                      fontWeight: FWT.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        60,
                        (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            width: 2,
                            height: index == 30
                                ? 40
                                : (index % 5 == 0)
                                    ? 25
                                    : 15,
                            decoration: BoxDecoration(
                              color: index == 30
                                  ? ColorUtilities.primary_500
                                  : ColorUtilities.text_400,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Select specialist',
                    style: FontStyleUtilities.h5(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      fontWeight: FWT.semiBold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: detailsScreenList
                            .map(
                              (SearchScreenArtistModel e) => PopularArtistsCard(
                                themeController: _themeController,
                                image: e.image,
                                job: e.job,
                                name: e.name,
                                isSelected: e.isSelected,
                                popularCardType: PopularCardType.selectable,
                                onPress: () {
                                  setState(() {
                                    detailsScreenList.forEach((element) {
                                      element.isSelected = false;
                                    });
                                    e.isSelected = true;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 15, 10, 15),
                        color: ColorUtilities.transparant,
                        child: Text(
                          'Back',
                          style: FontStyleUtilities.h5(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.text_300
                                : ColorUtilities.text_500,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      title: "Continue",
                      suffixIcon: AssetUtilities.iosRightStrokeSvg,
                      onButtonTap: () {
                        Get.to(BookingFinalizeScreen());
                      },
                      width: 160,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getDateTimePicker() {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 105,
      alignment: Alignment.center,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: daysList
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                daysList.forEach((element) {
                                  element['isSelected'] = false;
                                });
                                e['isSelected'] = true;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                color: ColorUtilities.transparant,
                                border: Border.all(
                                  color: e['isSelected']
                                      ? ColorUtilities.primary_500
                                      : ColorUtilities.transparant,
                                  width: 2.5,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    e['day'],
                                    style: FontStyleUtilities.t3(
                                      fontColor: e['isSelected']
                                          ? (_themeController.isDarkMode
                                              ? ColorUtilities.primary_400
                                              : ColorUtilities.primary_700)
                                          : (_themeController.isDarkMode
                                              ? ColorUtilities.text_400
                                              : ColorUtilities.text_600),
                                      fontWeight: e['isSelected']
                                          ? FWT.bold
                                          : FWT.semiBold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    e['date'].toString(),
                                    style: FontStyleUtilities.h5(
                                      fontColor: e['isSelected']
                                          ? (_themeController.isDarkMode
                                              ? ColorUtilities.primary_400
                                              : ColorUtilities.primary_700)
                                          : (_themeController.isDarkMode
                                              ? ColorUtilities.text_400
                                              : ColorUtilities.text_600),
                                      fontWeight: e['isSelected']
                                          ? FWT.bold
                                          : FWT.semiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     width: screenSize.width / 6,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.centerLeft,
          //         end: Alignment.centerRight,
          //         colors: [
          //           _themeController.isDarkMode
          //               ? ColorUtilities.dark_900.withOpacity(0.5)
          //               : ColorUtilities.light_100.withOpacity(0.5),
          //           _themeController.isDarkMode
          //               ? ColorUtilities.dark_900.withOpacity(0)
          //               : ColorUtilities.light_100.withOpacity(0),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Container(
          //     width: screenSize.width / 6,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.centerRight,
          //         end: Alignment.centerLeft,
          //         colors: [
          //           _themeController.isDarkMode
          //               ? ColorUtilities.dark_900.withOpacity(0.5)
          //               : ColorUtilities.light_100.withOpacity(0.5),
          //           _themeController.isDarkMode
          //               ? ColorUtilities.dark_900.withOpacity(0)
          //               : ColorUtilities.light_100.withOpacity(0),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

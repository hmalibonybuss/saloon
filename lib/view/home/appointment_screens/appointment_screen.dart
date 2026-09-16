import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/pass_screen.dart';
import 'package:saloon_app/view/home/appointment_screens/upcomming_screen.dart';
import 'package:saloon_app/view/home/filter_screen/filter_screen.dart';

/// ignore: must_be_immutable
class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<Map> tabList = [
    {
      "title": "Upcoming",
      "isSelected": true,
    },
    {
      "title": "Pass",
      "isSelected": false,
    },
  ];

  bool isMapSelected = false;

  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Scaffold(
          backgroundColor: _themeController.isDarkMode
              ? ColorUtilities.dark_900
              : ColorUtilities.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'You Appointments',
                      style: FontStyleUtilities.h4(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.dark_900,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                    Spacer(),
                    CustomActionButton(
                      icon: isMapSelected
                          ? AssetUtilities.listStrokeSvg
                          : AssetUtilities.mapStrokeSvg,
                      iconSize: 15,
                      color: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.dark_900,
                      onTap: () {
                        setState(() {
                          isMapSelected = !isMapSelected;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    CustomActionButton(
                      icon: AssetUtilities.filterStrokeSvg,
                      iconSize: 15,
                      color: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.dark_900,
                      onTap: () {
                        Get.to(
                          FilterScreen(),
                          transition: Transition.downToUp,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  height: 55,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _themeController.isDarkMode
                          ? ColorUtilities.dark_800
                          : ColorUtilities.light_500,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: List.generate(
                      tabList.length,
                      (index) {
                        Map tab = tabList[index];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                tabList.forEach((element) {
                                  element['isSelected'] = false;
                                });
                                tabList[index]['isSelected'] = true;
                                _pageController.jumpToPage(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: tab['isSelected']
                                    ? (_themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900)
                                    : ColorUtilities.transparant,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tab['title'],
                                style: FontStyleUtilities.t2(
                                  fontColor: tab['isSelected']
                                      ? (_themeController.isDarkMode
                                          ? ColorUtilities.text_900
                                          : ColorUtilities.white)
                                      : (_themeController.isDarkMode
                                          ? ColorUtilities.text_500
                                          : ColorUtilities.text_900),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      UpcommingScreen(
                        isMapSelected: isMapSelected,
                      ),
                      PassScreen(
                        isMapSelected: isMapSelected,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

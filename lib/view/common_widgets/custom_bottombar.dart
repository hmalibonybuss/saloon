import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/common_widgets/custom_bottomsheet_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnChangePage = void Function(int);

/// ignore: must_be_immutable
class CustomBottonNavigationBar extends StatefulWidget {
  int selectedPageIndex;
  final OnChangePage onChangePage;

  CustomBottonNavigationBar(
      {Key key, this.onChangePage, this.selectedPageIndex = 0})
      : super(key: key);

  @override
  _CustomBottonNavigationBarState createState() =>
      _CustomBottonNavigationBarState();
}

class _CustomBottonNavigationBarState extends State<CustomBottonNavigationBar>
    with TickerProviderStateMixin {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<AnimationController> animationControllerList = [];
  List<Animation> animationList = [];

  final List<CustomBottomBarModel> customBottomsheetDataList = [
    CustomBottomBarModel(
      icon: AssetUtilities.homeSolidSvg,
      title: "Home",
      width: 15.67,
      height: 15.83,
    ),
    CustomBottomBarModel(
      icon: AssetUtilities.locationSolidSvg,
      title: "Location",
      width: 11.67,
      height: 16.67,
    ),
    CustomBottomBarModel(
      icon: AssetUtilities.calendarSolidSvg,
      title: "Calender",
      width: 15,
      height: 15.17,
    ),
    CustomBottomBarModel(
      icon: AssetUtilities.chatSolidSvg,
      title: "Chat",
      width: 16,
      height: 15,
    ),
    CustomBottomBarModel(
      icon: AssetUtilities.userSolidSvg,
      title: "Profile",
      width: 14,
      height: 15.58,
    ),
  ];

  @override
  void initState() {
    for (int i = 0; i < (customBottomsheetDataList.length); i++) {
      animationControllerList.add(
        AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        ),
      );
      animationList.add(
        Tween<double>(begin: 0, end: 25).animate(
          CurvedAnimation(
            parent: animationControllerList[i],
            curve: Curves.bounceInOut,
          ),
        ),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    animationControllerList.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Container(
          height: 70,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: _themeController.isDarkMode
                    ? ColorUtilities.text_900
                    : ColorUtilities.black,
                blurRadius: 30,
                offset: Offset(0, 10),
                spreadRadius: -25,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              customBottomsheetDataList.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    animationControllerList[index].forward().then((value) {
                      animationControllerList[index].reverse();
                    });
                    setState(() {
                      widget.selectedPageIndex = index;
                    });
                    widget.onChangePage(widget.selectedPageIndex);
                  },
                  child: AnimatedBuilder(
                    animation: animationList[index],
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.center,
                        color: ColorUtilities.transparant,
                        width: (screenSize.width - 10) /
                            (customBottomsheetDataList.length),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Opacity(
                                opacity:
                                    animationList[index].value == 0 ? 0 : 1,
                                child: Container(
                                  height: animationList[index].value * 1.5,
                                  width: animationList[index].value * 1.5,
                                  decoration: BoxDecoration(
                                    color: _themeController.isDarkMode
                                        ? ColorUtilities.text_900
                                        : ColorUtilities.white,
                                    border: Border.all(
                                      color: _themeController.isDarkMode
                                          ? ColorUtilities.white
                                          : ColorUtilities.text_900,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomSvgView(
                                imageUrl: customBottomsheetDataList[index].icon,
                                isFromAssets: true,
                                height: customBottomsheetDataList[index].height,
                                width: customBottomsheetDataList[index].width,
                                svgColor: _themeController.isDarkMode
                                    ? (widget.selectedPageIndex == index
                                        ? ColorUtilities.white
                                        : ColorUtilities.dark_700)
                                    : (widget.selectedPageIndex == index
                                        ? ColorUtilities.text_900
                                        : ColorUtilities.text_200),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

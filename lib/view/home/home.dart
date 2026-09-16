import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/login_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/appointment_screen.dart';
import 'package:saloon_app/view/home/chat_screens/chat_screen.dart';
import 'package:saloon_app/view/home/home_screens/home_screen.dart';
import 'package:saloon_app/view/home/location_screens/location_screen.dart';
import 'package:saloon_app/view/home/profile_screens/profile_screen.dart';
import 'package:saloon_app/view/popup_widgets/location_permission_popup.dart';

/// ignore: must_be_immutable
class Home extends StatefulWidget {
  int homeSelectedPageIndex;

  Home({Key key, this.homeSelectedPageIndex = 0}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  AnimationController _profileSliderAnimationController;
  Animation _profileSliderAnimation;

  /// OPEN LOCATION PERMISSION POPUP...
  _showLocationPermissionPopup() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.dialog(LocationPermissionPopup());
    });
  }

  PageController homePageController;
  bool isProfileOpenFromHome = false;

  @override
  void initState() {
    homePageController =
        PageController(initialPage: widget.homeSelectedPageIndex);

    _profileSliderAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
      reverseDuration: Duration(
        milliseconds: 200,
      ),
    );

    _profileSliderAnimation =
        Tween<double>(begin: 0.0, end: 280.0).animate(CurvedAnimation(
      parent: _profileSliderAnimationController,
      curve: Curves.decelerate,
      reverseCurve: Curves.decelerate,
    ));

    if (widget.homeSelectedPageIndex == 0) _showLocationPermissionPopup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            if (widget.homeSelectedPageIndex == 0) {
              Get.offAll(LoginScreen());
            } else {
              setState(() {
                widget.homeSelectedPageIndex = 0;
              });

              homePageController.jumpToPage(0);
            }
            return false;
          },
          child: SafeArea(
            child: Material(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ProfileScreen(
                    openFromHome: true,
                  ),
                  AnimatedBuilder(
                      animation: _profileSliderAnimation,
                      builder: (context, snapshot) {
                        return Positioned(
                          top: isProfileOpenFromHome ? 5 : 0,
                          bottom: 0,
                          left: _profileSliderAnimation.value,
                          child: Transform.scale(
                            alignment: Alignment.center,
                            scale: isProfileOpenFromHome ? 0.9 : 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isProfileOpenFromHome = false;
                                });

                                _profileSliderAnimationController.reverse();
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                height: screenSize.height - 30,
                                width: screenSize.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorUtilities.black,
                                      blurRadius: 30,
                                      spreadRadius: -15,
                                      offset: Offset(-5, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      isProfileOpenFromHome ? 20 : 0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      isProfileOpenFromHome ? 20 : 0),
                                  child: Scaffold(
                                    backgroundColor: _themeController.isDarkMode
                                        ? ColorUtilities.dark_900
                                        : ColorUtilities.white,
                                    body: PageView(
                                      controller: homePageController,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        HomeScreen(
                                          openProfile: () {
                                            setState(() {
                                              isProfileOpenFromHome =
                                                  !isProfileOpenFromHome;
                                            });
                                            if (isProfileOpenFromHome) {
                                              _profileSliderAnimationController
                                                  .forward();
                                            } else {
                                              _profileSliderAnimationController
                                                  .reverse();
                                            }
                                          },
                                        ),
                                        LocationScreen(),
                                        AppointmentScreen(),
                                        ChatScreen(),
                                        ProfileScreen(),
                                      ],
                                    ),
                                    bottomNavigationBar:
                                        CustomBottonNavigationBar(
                                      selectedPageIndex:
                                          widget.homeSelectedPageIndex,
                                      onChangePage: (int selectedPageIndex) {
                                        homePageController
                                            .jumpToPage(selectedPageIndex);
                                        setState(() {
                                          widget.homeSelectedPageIndex =
                                              selectedPageIndex;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

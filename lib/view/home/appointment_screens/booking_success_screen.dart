import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/home.dart';

/// ignore: must_be_immutable
class BookingSuccessScreen extends StatelessWidget {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

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
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50),
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorUtilities.green_600,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: CustomSvgView(
                              imageUrl: AssetUtilities.checkTrueStrokeSvg,
                              isFromAssets: true,
                              height: 40,
                              width: 40,
                              svgColor: ColorUtilities.green_600,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            'Your appointment booking is succesfully.',
                            style: FontStyleUtilities.h3(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 25),
                          Text(
                            'You can view the appointment booking info in the "Appointment" section.',
                            textAlign: TextAlign.center,
                            style: FontStyleUtilities.p1(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.text_400
                                  : ColorUtilities.text_700,
                              fontWeight: FWT.regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      title: "Continue Booking",
                      width: screenSize.width,
                      onButtonTap: () {
                        Get.offAll(Home(homeSelectedPageIndex: 2));
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(Home(homeSelectedPageIndex: 2));
                      },
                      child: Container(
                        color: ColorUtilities.transparant,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Go To appointment',
                          style: FontStyleUtilities.t2(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.primary_400
                                : ColorUtilities.primary_700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

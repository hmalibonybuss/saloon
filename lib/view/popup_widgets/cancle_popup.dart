import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class CanclePopup extends StatelessWidget {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      alignment: Alignment.center,
                      height: screenSize.height / 3,
                      width: screenSize.width - 50,
                      decoration: BoxDecoration(
                          color: _themeController.isDarkMode
                              ? ColorUtilities.dark_900
                              : ColorUtilities.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancellation of appointment',
                              style: FontStyleUtilities.h4(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                fontWeight: FWT.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Text(
                                'Are you sure you want to cancel this appointment?',
                                textAlign: TextAlign.center,
                                style: FontStyleUtilities.t3(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.white
                                      : ColorUtilities.text_900,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  title: "Cancel",
                                  width: (screenSize.width / 2) - 50,
                                  isFlatButton: true,
                                  onButtonTap: () {
                                    Get.back();
                                  },
                                ),
                                CustomButton(
                                  title: "Submit",
                                  buttonColor: ColorUtilities.red_500,
                                  width: (screenSize.width / 2) - 50,
                                  onButtonTap: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

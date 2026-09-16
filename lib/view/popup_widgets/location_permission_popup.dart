import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class LocationPermissionPopup extends StatelessWidget {
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
                alignment: Alignment.topCenter,
                child: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      alignment: Alignment.center,
                      height: screenSize.height / 2,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: _themeController.isDarkMode
                            ? ColorUtilities.dark_900
                            : ColorUtilities.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Enable Location',
                              style: FontStyleUtilities.h4(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                fontWeight: FWT.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomImageView(
                              imageUrl: AssetUtilities.enableLocationPng,
                              isFromAssets: true,
                              height: 100,
                              width: 90,
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Text(
                                'We need to know your location in order to suggest nearby services.',
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
                            CustomButton(
                              title: "Enable",
                              width: (screenSize.width / 2) - 40,
                              onButtonTap: () {
                                Get.back();
                              },
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

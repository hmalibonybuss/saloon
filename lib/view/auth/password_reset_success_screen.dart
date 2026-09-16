import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/home.dart';

/// ignore: must_be_immutable
class PasswordResetSuccessScreen extends StatelessWidget {
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
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorUtilities.green_500,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CustomSvgView(
                        imageUrl: AssetUtilities.checkTrueStrokeSvg,
                        isFromAssets: true,
                        height: 30,
                        width: 30,
                        svgColor: ColorUtilities.green_500,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Password Reset',
                      style: FontStyleUtilities.h3(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Your password has been reset successfully',
                      textAlign: TextAlign.center,
                      style: FontStyleUtilities.p1(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.regular,
                      ),
                    ),
                    SizedBox(height: 50),
                    CustomButton(
                      title: "Sign In",
                      width: screenSize.width / 2,
                      onButtonTap: () {
                        Get.offAll(Home());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

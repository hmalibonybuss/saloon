import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/reset_password_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class VarificationMailSentScreen extends StatelessWidget {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSvgView(
                      imageUrl: AssetUtilities.mailStrokeSvg,
                      isFromAssets: true,
                      height: 60,
                      width: 60,
                      svgColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Code has been sent',
                      style: FontStyleUtilities.h3(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'You\'ll shortly recieve an email with a code to setup a new password.',
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
                      title: "Done",
                      width: screenSize.width / 2,
                      onButtonTap: () {
                        Get.to(ResetPasswordScreen());
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

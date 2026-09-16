import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/auth_common_widgets/auth_common_widgets.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/home.dart';

/// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Scaffold(
            backgroundColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: BackArrow(
                      onBackTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify phone',
                          style: FontStyleUtilities.h1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Please enter the 4 digit security code we just sent you at ',
                                style: FontStyleUtilities.p2(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.text_400
                                      : ColorUtilities.text_300,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                              TextSpan(
                                text: '713-444-XXXX',
                                style: FontStyleUtilities.p2(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.primary_400
                                      : ColorUtilities.primary_700,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        OTPField(
                          otpLength: 4,
                          onSubmit: (String otp) async {
                            await Future.delayed(Duration(seconds: 1));
                            Get.to(Home(homeSelectedPageIndex: 0));
                          },
                        ),
                        SizedBox(height: 120),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                'Resend in 40 Sec',
                                style: FontStyleUtilities.t3(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.primary_400
                                      : ColorUtilities.primary_700,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

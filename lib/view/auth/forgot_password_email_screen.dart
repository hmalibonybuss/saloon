import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/auth/varification_mail_sent_screen.dart';

/// ignore: must_be_immutable
class ForgotPasswordEmailScreen extends StatelessWidget {
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: BackArrow(
                    onBackTap: () {
                      Get.back();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80),
                          Text(
                            'Forgot Password',
                            style: FontStyleUtilities.h1(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Please enter your email address to reset your password instruction',
                            style: FontStyleUtilities.p2(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.text_400
                                  : ColorUtilities.text_300,
                              fontWeight: FWT.regular,
                            ),
                          ),
                          SizedBox(height: 40),
                          CustomTextField(
                            hint: "Email",
                            icon: AssetUtilities.mailStrokeSvg,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 40),
                          CustomButton(
                            title: "Send Link",
                            buttonSize: ButtonSize.big,
                            onButtonTap: () {
                              Get.to(VarificationMailSentScreen());
                            },
                            width: screenSize.width,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/forgot_password_email_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                'Select which contact details should we use to reset your password:',
                                style: FontStyleUtilities.p2(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.text_400
                                      : ColorUtilities.text_300,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                              SizedBox(height: 30),
                              ForgotPasswordOptionTile(
                                icon: AssetUtilities.mailStrokeSvg,
                                title: "Via email",
                                onTap: () {
                                  Get.to(ForgotPasswordEmailScreen());
                                },
                              ),
                              SizedBox(height: 30),
                              ForgotPasswordOptionTile(
                                icon: AssetUtilities.mobileStrokeSvg,
                                title: "Via sms",
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

/// ignore: must_be_immutable
class ForgotPasswordOptionTile extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final String icon;
  final VoidCallback onTap;
  ForgotPasswordOptionTile({
    Key key,
    this.title,
    this.icon,
    this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return GestureDetector(
            onTap: onTap ?? () {},
            child: Container(
              height: height ?? 100,
              width: width ?? screenSize.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: _themeController.isDarkMode
                    ? ColorUtilities.dark_800
                    : ColorUtilities.light_300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  CustomSvgView(
                    imageUrl: icon ?? AssetUtilities.userStrokeSvg,
                    isFromAssets: true,
                    height: 20,
                    width: 20,
                    svgColor: _themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                  ),
                  SizedBox(width: 20),
                  Text(
                    title ?? '',
                    style: FontStyleUtilities.t1(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      fontWeight: FWT.regular,
                    ),
                  ),
                  Spacer(),
                  CustomSvgView(
                    imageUrl: AssetUtilities.iosRightStrokeSvg,
                    isFromAssets: true,
                    height: 20,
                    width: 20,
                    svgColor: _themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

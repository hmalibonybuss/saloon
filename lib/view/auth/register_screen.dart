import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/verify_phone_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
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
                SizedBox(height: 30),
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
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign up',
                                style: FontStyleUtilities.h1(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.white
                                      : ColorUtilities.text_900,
                                  fontWeight: FWT.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Create a new account',
                                style: FontStyleUtilities.t1(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.text_400
                                      : ColorUtilities.text_300,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                              SizedBox(height: 40),
                              CustomTextField(
                                icon: AssetUtilities.userStrokeSvg,
                                hint: "Name",
                              ),
                              SizedBox(height: 25),
                              CustomTextField(
                                icon: AssetUtilities.mailStrokeSvg,
                                hint: "Email",
                              ),
                              SizedBox(height: 25),
                              CustomTextField(
                                icon: AssetUtilities.lockStrokeSvg,
                                hint: "Password",
                              ),
                              SizedBox(height: 16),
                              CustomButton(
                                buttonColor: ColorUtilities.primary_500,
                                height: 58,
                                width: screenSize.width,
                                title: "Sign Up",
                                onButtonTap: () {
                                  Get.to(VerifyPhoneScreen());
                                },
                              ),
                              SizedBox(height: 25),
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'By continuing Sign up you agree to following ',
                                          style: FontStyleUtilities.t4(
                                            fontColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.text_400
                                                    : ColorUtilities.text_300,
                                            fontWeight: FWT.regular,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Terms & Conditions ',
                                          style: FontStyleUtilities.t4(
                                            fontColor: _themeController
                                                    .isDarkMode
                                                ? ColorUtilities.primary_400
                                                : ColorUtilities.primary_700,
                                            fontWeight: FWT.regular,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'without reservation.',
                                          style: FontStyleUtilities.t4(
                                            fontColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.text_400
                                                    : ColorUtilities.text_300,
                                            fontWeight: FWT.regular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 130),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: FontStyleUtilities.t3(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.text_400
                                            : ColorUtilities.text_300,
                                        fontWeight: FWT.regular,
                                      ),
                                    ),
                                    Text(
                                      'Sign In',
                                      style: FontStyleUtilities.t3(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.primary_700
                                            : ColorUtilities.primary_400,
                                        fontWeight: FWT.semiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/forgot_password_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/auth/register_screen.dart';
import 'package:saloon_app/view/home/home.dart';

/// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  bool isRememberMeSelected = true;

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
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: BackArrow(
                      color: _themeController.isDarkMode
                          ? ColorUtilities.dark_100
                          : ColorUtilities.text_900,
                      onBackTap: () {
                        Get.offAll(ThemeHomePage());
                      },
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: FontStyleUtilities.h1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Sign in to continue',
                          style: FontStyleUtilities.t1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.text_400
                                : ColorUtilities.text_300,
                            fontWeight: FWT.regular,
                          ),
                        ),
                        SizedBox(height: 40),
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
                        Row(
                          children: [
                            CustomCheckBox(
                              isSelected: isRememberMeSelected,
                              onChange: (bool selectedValue) {
                                setState(() {
                                  isRememberMeSelected = selectedValue;
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Remember me',
                              style: FontStyleUtilities.t3(
                                fontColor: ColorUtilities.primary_500,
                                fontWeight: FWT.regular,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        CustomButton(
                          buttonColor: ColorUtilities.primary_500,
                          height: 58,
                          width: screenSize.width,
                          title: "Sign In",
                          onButtonTap: () {
                            Get.to(Home());
                          },
                        ),
                        SizedBox(height: 35),
                        Center(
                          child: Text(
                            'Or Continue with',
                            style: FontStyleUtilities.t3(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.text_400
                                  : ColorUtilities.text_500,
                              fontWeight: FWT.regular,
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomSocialButton(
                              icon: AssetUtilities.facebookSocialPng,
                              onButtonTap: () {},
                            ),
                            SizedBox(width: 20),
                            CustomSocialButton(
                              icon: AssetUtilities.googleSocialPng,
                              onButtonTap: () {},
                            ),
                            SizedBox(width: 20),
                            CustomSocialButton(
                              icon: AssetUtilities.twitterSocialPng,
                              onButtonTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 45),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(ForgotPasswordScreen());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Forgot your password?',
                                style: FontStyleUtilities.t3(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.text_400
                                      : ColorUtilities.text_300,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(RegisterScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: FontStyleUtilities.t3(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.text_400
                                      : ColorUtilities.text_300,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                              Text(
                                'Sign Up',
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
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/auth_common_widgets/auth_common_widgets.dart';
import 'package:saloon_app/view/auth/otp_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class VerifyPhoneScreen extends StatelessWidget {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                          'Your phone !',
                          style: FontStyleUtilities.h1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'A 4 digit security code will be sent via SMS to verify your mobile number!',
                          style: FontStyleUtilities.t1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.text_400
                                : ColorUtilities.text_300,
                            fontWeight: FWT.regular,
                          ),
                        ),
                        SizedBox(height: 40),
                        Form(
                          key: _formKey,
                          child: VerifyPhoneField(
                            hint: "Enter number",
                            validator: (String value) {
                              if (value.length < 10 || value.length > 12) {
                                return "Please Enter Correct Number";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        CustomButton(
                          buttonColor: ColorUtilities.primary_500,
                          height: 58,
                          width: screenSize.width,
                          title: "Continue",
                          onButtonTap: () {
                            if (_formKey.currentState.validate()) {
                              Get.to(OtpScreen());
                            }
                          },
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

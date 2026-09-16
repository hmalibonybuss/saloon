import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/auth/login_screen.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/favorite/favorite_screen.dart';
import 'package:saloon_app/view/home/notification_screen.dart';
import 'package:saloon_app/view/home/profile_screens/edit_profile_screen.dart';
import 'package:saloon_app/view/home/profile_screens/faq_screen.dart';
import 'package:saloon_app/view/payment/payment_screen.dart';

/// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  final bool openFromHome;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  ProfileScreen({Key key, this.openFromHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imageUrl: AssetUtilities.homeScreenProfilePng,
                          isFromAssets: true,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(20),
                        ),
                        Spacer(),
                        CustomActionButton(
                          icon: _themeController.isDarkMode
                              ? AssetUtilities.bellDotWStrokeSvg
                              : AssetUtilities.bellDotStrokeSvg,
                          takeDefaultColor: true,
                          onTap: () {
                            Get.to(NotificationScreen());
                          },
                        ),
                        SizedBox(width: 10),
                        CustomActionButton(
                          icon: AssetUtilities.heartStrokeSvg,
                          color: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          onTap: () {
                            Get.to(FavoriteScreen());
                          },
                        ),
                        SizedBox(
                          width: openFromHome ? 90 : 0,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Robert Fox',
                          style: FontStyleUtilities.h4(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditProfileScreen());
                          },
                          child: CustomSvgView(
                            imageUrl: AssetUtilities.editStrokeSvg,
                            isFromAssets: true,
                            height: 16,
                            width: 16,
                            svgColor: ColorUtilities.primary_500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'robert_fox@gmail.com',
                      style: FontStyleUtilities.t3(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.text_300
                            : ColorUtilities.text_300,
                        fontWeight: FWT.regular,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        {
                          "icon": AssetUtilities.creditCardStrokeSvg,
                          "title": "Payment Method",
                          "onTap": () {
                            Get.to(PaymentScreen());
                          },
                        },
                        {
                          "icon": AssetUtilities.historyStrokeSvg,
                          "title": "Payment History",
                          "onTap": () {},
                        },
                        {
                          "icon": AssetUtilities.lockStrokeSvg,
                          "title": "Change Password",
                          "onTap": () {},
                        },
                        {
                          "icon": AssetUtilities.peopleStrokeSvg,
                          "title": "Invites Friends",
                          "onTap": () {},
                        },
                        {
                          "icon": AssetUtilities.commentQuestionStrokeSvg,
                          "title": "FAQs",
                          "onTap": () {
                            Get.to(FAQScreen());
                          },
                        },
                        {
                          "icon": AssetUtilities.questionCircleStrokeSvg,
                          "title": "About Us",
                          "onTap": () {},
                        },
                        {
                          "icon": AssetUtilities.closeCircleStrokeSvg,
                          "title": "Logout",
                          "onTap": () {
                            Get.offAll(LoginScreen());
                          },
                        },
                      ]
                          .map(
                            (e) => GestureDetector(
                              onTap: e['onTap'] ?? () {},
                              child: Container(
                                height: 42,
                                width: screenSize.width,
                                margin: EdgeInsets.symmetric(
                                    vertical: e['title'] == "Logout"
                                        ? (openFromHome ? 60 : 20)
                                        : 10),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: ColorUtilities.transparant,
                                ),
                                child: Row(
                                  children: [
                                    (e['icon'] == null) && !openFromHome
                                        ? SizedBox()
                                        : CustomSvgView(
                                            imageUrl: e['icon'],
                                            isFromAssets: true,
                                            height: 25,
                                            width: 25,
                                            svgColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.text_300
                                                    : ColorUtilities.text_900,
                                          ),
                                    SizedBox(width: openFromHome ? 0 : 10),
                                    Text(
                                      e['title'] ?? '',
                                      style: FontStyleUtilities.t1(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.text_300
                                            : ColorUtilities.text_900,
                                        fontWeight: FWT.regular,
                                      ),
                                    ),
                                    Spacer(),
                                    e['title'] == "Logout"
                                        ? SizedBox()
                                        : CustomSvgView(
                                            imageUrl: AssetUtilities
                                                .iosRightStrokeSvg,
                                            isFromAssets: true,
                                            height: 25,
                                            width: 25,
                                            svgColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.text_300
                                                    : ColorUtilities.text_900,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

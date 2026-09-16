import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class SharePopup extends StatefulWidget {
  final PackageModel package;

  const SharePopup({Key key, this.package}) : super(key: key);
  @override
  _SharePopupState createState() => _SharePopupState();
}

class _SharePopupState extends State<SharePopup> {
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
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
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
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Share to',
                            style: FontStyleUtilities.h5(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Wrap(
                            children: [
                              {
                                "icon": AssetUtilities.facebookSocialPng,
                                "title": "Facebook"
                              },
                              {
                                "icon": AssetUtilities.googleSocialPng,
                                "title": "Gmail"
                              },
                              {
                                "icon": AssetUtilities.twitterSocialPng,
                                "title": "Twitter"
                              },
                              {
                                "icon": AssetUtilities.pinterestSocialPng,
                                "title": "Pinterest"
                              },
                              {
                                "icon": AssetUtilities.instagramSocialPng,
                                "title": "Instagram"
                              },
                              {
                                "icon": AssetUtilities.messengerSocialPng,
                                "title": "Messanger"
                              },
                            ]
                                .map(
                                  (e) => Container(
                                    width: (screenSize.width - 60) / 3,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomSocialButton(
                                          icon: e['icon'],
                                          iconSize: 22,
                                          buttonHeight: 60,
                                          buttonWidth: 60,
                                          onButtonTap: () {},
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          e['title'],
                                          style: FontStyleUtilities.t4(
                                            fontColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.text_400
                                                    : ColorUtilities.text_900,
                                          ),
                                        )
                                      ],
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
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/utilities/font_style_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class FAQScreen extends StatelessWidget {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeController>(
          init: _themeController,
          builder: (_) {
            return Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white,
              body: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'FAQs',
                          style: FontStyleUtilities.h3(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            color: ColorUtilities.transparant,
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            child: CustomSvgView(
                              imageUrl: AssetUtilities.closeStrokeSvg,
                              isFromAssets: true,
                              height: 15,
                              width: 15,
                              svgColor: _themeController.isDarkMode
                                  ? ColorUtilities.dark_100
                                  : ColorUtilities.text_900,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  CustomExpansionPanel(
                    title: "What is Flo Clutter?",
                    content:
                        "We provide highend services without the highend price. A moderate price allows us to provide the high end services you enjoy and the lower price allows you to enjoy it more often! Prices for services are subject to consultation.",
                    onExpandTile: (bool value) {},
                  ),
                  Divider(),
                  CustomExpansionPanel(
                    title: "How much does this cost?",
                    content:
                        "We provide highend services without the highend price. A moderate price allows us to provide the high end services you enjoy and the lower price allows you to enjoy it more often! Prices for services are subject to consultation.",
                    onExpandTile: (bool value) {},
                  ),
                  Divider(),
                  CustomExpansionPanel(
                    title: "Do you acept paypal?",
                    content:
                        "We provide highend services without the highend price. A moderate price allows us to provide the high end services you enjoy and the lower price allows you to enjoy it more often! Prices for services are subject to consultation.",
                    onExpandTile: (bool value) {},
                  ),
                  Divider(),
                  CustomExpansionPanel(
                    title: "Where are you located?",
                    content:
                        "We provide highend services without the highend price. A moderate price allows us to provide the high end services you enjoy and the lower price allows you to enjoy it more often! Prices for services are subject to consultation.",
                    onExpandTile: (bool value) {},
                  ),
                  Divider(),
                  CustomExpansionPanel(
                    title:
                        "Can I just come in or do I have to make an appointment?",
                    content:
                        "We provide highend services without the highend price. A moderate price allows us to provide the high end services you enjoy and the lower price allows you to enjoy it more often! Prices for services are subject to consultation.",
                    onExpandTile: (bool value) {},
                  ),
                  Divider(),
                ],
              ),
            );
          }),
    );
  }
}

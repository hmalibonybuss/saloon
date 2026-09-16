import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class VoucherCard extends StatelessWidget {
  final String percentage;
  final String message;
  final String image;
  final VoidCallback onTap;

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  VoucherCard({Key key, this.percentage, this.message, this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Container(
            height: 180,
            width: screenSize.width,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 160,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: _themeController.isDarkMode
                          ? ColorUtilities.dark_800
                          : ColorUtilities.light_300,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: screenSize.width / 2,
                      top: 15,
                      bottom: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          percentage ?? '',
                          style: FontStyleUtilities.h2(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                        Text(
                          message ?? '',
                          style: FontStyleUtilities.t4(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.text_400
                                : ColorUtilities.text_900,
                            fontWeight: FWT.regular,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomButton(
                          title: "Book Now",
                          height: 36,
                          onButtonTap: onTap ?? () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomImageView(
                    imageUrl: image ?? '',
                    isFromAssets: true,
                    height: 180,
                    width: (screenSize.width / 2) - 50,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(25),
                  ),
                )
              ],
            ),
          );
        });
  }
}

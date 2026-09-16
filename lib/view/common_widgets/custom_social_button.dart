import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class CustomSocialButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final double iconSize;
  final String icon;
  final VoidCallback onButtonTap;
  CustomSocialButton(
      {Key key,
      this.onButtonTap,
      this.icon,
      this.buttonHeight,
      this.buttonWidth,
      this.iconSize})
      : super(key: key);

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return GestureDetector(
          onTap: onButtonTap ?? () {},
          child: Container(
              height: buttonHeight ?? 50,
              width: buttonWidth ?? 50,
              decoration: BoxDecoration(
                color: ColorUtilities.transparant,
                border: Border.all(
                    color: _themeController.isDarkMode
                        ? ColorUtilities.dark_800
                        : ColorUtilities.text_100),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: CustomImageView(
                imageUrl: icon,
                isFromAssets: true,
                height: 18,
                width: 18,
                fit: BoxFit.cover,
              )),
        );
      },
    );
  }
}

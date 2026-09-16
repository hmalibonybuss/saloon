import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class CustomActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final Color color;
  final double height;
  final double width;
  final double iconSize;
  final double radius;

  final bool takeDefaultColor;
  CustomActionButton({
    Key key,
    this.onTap,
    this.icon,
    this.color,
    this.takeDefaultColor,
    this.height,
    this.width,
    this.iconSize,
    this.radius,
  }) : super(key: key);

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return GestureDetector(
            onTap: onTap ?? () {},
            child: Container(
              height: height ?? 45,
              width: width ?? 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 12),
                border: Border.all(
                  color: _themeController.isDarkMode
                      ? ColorUtilities.dark_700
                      : ColorUtilities.text_100,
                ),
              ),
              alignment: Alignment.center,
              child: CustomSvgView(
                imageUrl: icon ?? AssetUtilities.heartStrokeSvg,
                isFromAssets: true,
                width: iconSize ?? 15,
                height: iconSize ?? 15,
                svgColor: color ?? ColorUtilities.black,
                takeDefaultColor: takeDefaultColor ?? false,
              ),
            ),
          );
        });
  }
}

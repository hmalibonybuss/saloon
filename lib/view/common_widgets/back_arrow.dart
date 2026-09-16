import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class BackArrow extends StatelessWidget {
  final VoidCallback onBackTap;
  final Color color;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  BackArrow({Key key, this.onBackTap, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return GestureDetector(
            onTap: onBackTap ?? () {},
            child: Container(
              color: ColorUtilities.transparant,
              padding: EdgeInsets.only(left: 0, top: 20, bottom: 20, right: 20),
              child: CustomSvgView(
                imageUrl: AssetUtilities.arrowBackStrokeSvg,
                isFromAssets: true,
                height: 20,
                width: 20,
                svgColor: color ??
                    (_themeController.isDarkMode
                        ? ColorUtilities.dark_100
                        : ColorUtilities.text_900),
              ),
            ),
          );
        });
  }
}

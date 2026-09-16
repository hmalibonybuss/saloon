import 'package:flutter/material.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnRateChange = void Function(int);
getStars(
  ThemeController _themeController, {
  int starCount,
  bool isDetailed = false,
  OnRateChange onRateChange,
  Size size,
}) {
  return isDetailed
      ? Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [1, 2, 3, 4, 5]
              .map((int stars) => GestureDetector(
                    onTap: () {
                      onRateChange(stars);
                                        },
                    child: CustomSvgView(
                      imageUrl: AssetUtilities.starSolidSvg,
                      isFromAssets: true,
                      width: size.height ?? 12,
                      height: size.width ?? 12,
                      svgColor: stars <= starCount
                          ? ColorUtilities.yellow_500
                          : (_themeController.isDarkMode
                              ? ColorUtilities.dark_700
                              : ColorUtilities.light_900),
                    ),
                  ))
              .toList(),
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvgView(
              imageUrl: AssetUtilities.starSolidSvg,
              isFromAssets: true,
              width: 12,
              height: 12,
              svgColor: ColorUtilities.yellow_500,
            ),
            SizedBox(width: 5),
            Text(
              "$starCount.0",
              style: FontStyleUtilities.t3(
                fontColor: ColorUtilities.yellow_600,
                fontWeight: FWT.regular,
              ),
            ),
          ],
        );
}

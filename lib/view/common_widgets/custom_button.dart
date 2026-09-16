import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

enum ButtonSize {
  small,
  medium,
  big,
}

/// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final String secondTitle;
  final String preffixIcon;
  final String suffixIcon;
  final bool isFlatButton;
  final Color buttonColor;
  final ButtonSize buttonSize;
  final VoidCallback onButtonTap;
  CustomButton(
      {Key key,
      this.height,
      this.width,
      this.title,
      this.preffixIcon,
      this.suffixIcon,
      this.isFlatButton = false,
      this.buttonColor,
      this.buttonSize = ButtonSize.big,
      this.onButtonTap,
      this.secondTitle})
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: height ??
                ((buttonSize == ButtonSize.big)
                    ? 58
                    : (buttonSize == ButtonSize.medium)
                        ? 48
                        : 28),
            width: width,
            decoration: BoxDecoration(
              color: isFlatButton
                  ? ColorUtilities.transparant
                  : buttonColor ?? ColorUtilities.primary_500,
              border: isFlatButton
                  ? Border.all(
                      color: _themeController.isDarkMode
                          ? ColorUtilities.dark_700
                          : ColorUtilities.text_100)
                  : null,
              borderRadius: BorderRadius.circular((buttonSize == ButtonSize.big)
                  ? 10
                  : (buttonSize == ButtonSize.medium)
                      ? 10
                      : 7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                preffixIcon != null
                    ? CustomSvgView(
                        imageUrl: preffixIcon,
                        height: 16,
                        width: 16,
                        isFromAssets: true,
                        svgColor: isFlatButton
                            ? ColorUtilities.text_900
                            : ColorUtilities.white,
                      )
                    : SizedBox(),
                SizedBox(width: preffixIcon != null ? 10 : 0),
                Text(
                  title ?? '',
                  style: buttonSize == ButtonSize.small
                      ? FontStyleUtilities.t3(
                          fontColor: isFlatButton
                              ? _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900
                              : ColorUtilities.white,
                          fontWeight: FWT.semiBold,
                        )
                      : FontStyleUtilities.t2(
                          fontColor: isFlatButton
                              ? _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : _themeController.isDarkMode
                                      ? ColorUtilities.white
                                      : ColorUtilities.text_900
                              : ColorUtilities.white,
                          fontWeight: FWT.semiBold,
                        ),
                ),
                SizedBox(width: suffixIcon != null ? 10 : 1),
                suffixIcon != null
                    ? CustomSvgView(
                        imageUrl: suffixIcon,
                        height: 16,
                        width: 16,
                        isFromAssets: true,
                        svgColor: isFlatButton
                            ? ColorUtilities.text_900
                            : ColorUtilities.white,
                      )
                    : SizedBox(),
                secondTitle != null ? Spacer() : SizedBox(),
                secondTitle != null
                    ? Text(
                        secondTitle ?? '',
                        style: buttonSize == ButtonSize.small
                            ? FontStyleUtilities.t3(
                                fontColor: isFlatButton
                                    ? ColorUtilities.text_900
                                    : ColorUtilities.white,
                                fontWeight: FWT.semiBold,
                              )
                            : FontStyleUtilities.t2(
                                fontColor: isFlatButton
                                    ? ColorUtilities.text_900
                                    : ColorUtilities.white,
                                fontWeight: FWT.semiBold,
                              ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}

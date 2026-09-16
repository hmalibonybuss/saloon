import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnChangeValue = void Function(String);

/// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final Widget suffixIcon;
  final String hint;
  final bool obsecure;
  final double height;
  final double width;
  final TextInputType keyboardType;
  final VoidCallback onTap;
  final OnChangeValue onChange;
  final List<TextInputFormatter> inputFormatter;
  CustomTextField(
      {Key key,
      this.controller,
      this.icon,
      this.hint,
      this.obsecure = false,
      this.keyboardType,
      this.height,
      this.width,
      this.onTap,
      this.onChange,
      this.inputFormatter,
      this.suffixIcon})
      : super(key: key);

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Container(
            height: height ?? 58,
            width: width ?? screenSize.width,
            decoration: BoxDecoration(
              color: _themeController.isDarkMode
                  ? ColorUtilities.dark_800
                  : ColorUtilities.light_300,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon != null
                    ? CustomSvgView(
                        imageUrl: icon,
                        isFromAssets: true,
                        height: 16,
                        width: 16,
                        svgColor: _themeController.isDarkMode
                            ? ColorUtilities.dark_100
                            : ColorUtilities.text_900,
                      )
                    : SizedBox(),
                SizedBox(width: icon != null ? 10 : 0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2),
                      TextFormField(
                        controller: controller,
                        obscureText: obsecure,
                        keyboardType: keyboardType ?? TextInputType.text,
                        onTap: onTap ?? () {},
                        onChanged: onChange ?? (String value) {},
                        inputFormatters: inputFormatter ?? [],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint,
                          hintStyle: FontStyleUtilities.t2(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.text_500
                                : ColorUtilities.text_300,
                            fontWeight: FWT.regular,
                          ),
                        ),
                        style: FontStyleUtilities.t2(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          fontWeight: FWT.regular,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: suffixIcon != null ? 10 : 0),
                suffixIcon ?? SizedBox(),
              ],
            ),
          );
        });
  }
}

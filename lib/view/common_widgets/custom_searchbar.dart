import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class CustomSearchbar extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final String actionIcon;
  final VoidCallback onSearchActionTap;
  CustomSearchbar({
    Key key,
    this.height,
    this.width,
    this.controller,
    this.onSearchActionTap,
    this.hintText,
    this.icon,
    this.actionIcon,
  }) : super(key: key);

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Container(
          height: height ?? 60,
          width: width ?? screenSize.width,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: _themeController.isDarkMode
                ? ColorUtilities.dark_800
                : ColorUtilities.light_300,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSvgView(
                imageUrl: icon ?? AssetUtilities.searchStrokeSvg,
                isFromAssets: true,
                height: 20,
                width: 19,
                svgColor: _themeController.isDarkMode
                    ? ColorUtilities.dark_300
                    : ColorUtilities.text_200,
              ),
              SizedBox(width: 5),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText ?? "",
                    hintStyle: FontStyleUtilities.t2(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.text_500
                          : ColorUtilities.text_200,
                    ),
                  ),
                  style: FontStyleUtilities.t2(
                    fontColor: _themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                    fontWeight: FWT.regular,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onSearchActionTap ?? () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: ColorUtilities.transparant,
                  child: CustomSvgView(
                    imageUrl: actionIcon ?? AssetUtilities.filterStrokeSvg,
                    isFromAssets: true,
                    height: 19,
                    width: 19,
                    svgColor: _themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

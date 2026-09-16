import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnChangeDropdownValue = void Function(dynamic);

/// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  final double height;
  final double width;
  final String hint;
  final dynamic selectedValue;
  final OnChangeDropdownValue onChange;
  final List<DropdownMenuItem> items;
  final bool isExpanded;
  final bool isFlat;
  final String icon;

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  CustomDropDown({
    Key key,
    this.height,
    this.width,
    this.items,
    this.hint,
    this.selectedValue,
    this.onChange,
    this.isExpanded,
    this.isFlat = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Container(
          height: height ?? isFlat ? 30 : 58,
          width: width ?? null,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isFlat
                ? ColorUtilities.transparant
                : _themeController.isDarkMode
                    ? ColorUtilities.dark_800
                    : ColorUtilities.light_300,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: isFlat ? 0 : 20, vertical: isFlat ? 0 : 17),
          child: DropdownButton(
            items: items,
            dropdownColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            hint: Text(
              hint ?? '',
              style: FontStyleUtilities.t2(
                fontColor: _themeController.isDarkMode
                    ? ColorUtilities.text_500
                    : ColorUtilities.text_300,
                fontWeight: FWT.regular,
              ),
            ),
            value: selectedValue,
            icon: CustomSvgView(
              imageUrl: icon ?? AssetUtilities.dropDownStrokeSvg,
              isFromAssets: true,
              height: 12,
              width: 12,
              svgColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_100
                  : ColorUtilities.text_900,
            ),
            isExpanded: isExpanded ?? true,
            underline: SizedBox(),
            onChanged: onChange ?? (value) {},
            style: FontStyleUtilities.t2(
              fontColor: _themeController.isDarkMode
                  ? ColorUtilities.white
                  : ColorUtilities.text_900,
              fontWeight: FWT.regular,
            ),
          ),
        );
      },
    );
  }
}

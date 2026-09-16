import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/color_utils.dart';

typedef OnSwitchChange = void Function(bool);

/// ignore: must_be_immutable
class CustomSwitchButton extends StatefulWidget {
  final OnSwitchChange onChange;
  bool isSelected;
  CustomSwitchButton({Key key, this.onChange, this.isSelected = false})
      : super(key: key);

  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton>
    with TickerProviderStateMixin {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return GestureDetector(
          onTap: () {
            widget.isSelected = !widget.isSelected;
            widget.onChange(widget.isSelected);
            setState(() {});
          },
          child: Container(
            height: 25,
            width: 50,
            padding: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? ColorUtilities.primary_500
                  : (_themeController.isDarkMode
                      ? ColorUtilities.dark_700
                      : ColorUtilities.light_900),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Align(
              alignment: widget.isSelected
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? ColorUtilities.white
                      : (_themeController.isDarkMode
                          ? ColorUtilities.dark_300
                          : ColorUtilities.white),
                  shape: BoxShape.circle,
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 10,
                  //     offset: Offset(0, 3),
                  //     color: ColorUtilities.black.withOpacity(0.5),
                  //   ),
                  // ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

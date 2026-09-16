import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnChipTap = void Function(bool);
enum ChipType {
  close,
  simple,
}

/// ignore: must_be_immutable
class CommonChip extends StatefulWidget {
  final String title;
  final OnChipTap onChipTap;
  final ChipType chipType;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final inactiveTextColor;
  final double radius;
  bool isSelected;

  CommonChip(
      {Key key,
      this.title,
      this.onChipTap,
      this.isSelected = false,
      this.chipType = ChipType.simple,
      this.inactiveColor,
      this.activeColor,
      this.radius,
      this.activeTextColor,
      this.inactiveTextColor})
      : super(key: key);

  @override
  _CommonChipState createState() => _CommonChipState();
}

class _CommonChipState extends State<CommonChip> {
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
              setState(() {
                widget.onChipTap(widget.isSelected);
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? widget.activeColor ?? ColorUtilities.primary_500
                    : widget.inactiveColor ??
                        (_themeController.isDarkMode
                            ? ColorUtilities.dark_800
                            : ColorUtilities.light_400),
                borderRadius: BorderRadius.circular(widget.radius ?? 10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title ?? '',
                    style: FontStyleUtilities.t3(
                      fontColor: widget.isSelected
                          ? widget.activeTextColor ??
                              (_themeController.isDarkMode
                                  ? ColorUtilities.text_900
                                  : ColorUtilities.white)
                          : widget.inactiveTextColor ??
                              (_themeController.isDarkMode
                                  ? ColorUtilities.text_500
                                  : ColorUtilities.text_200),
                      fontWeight:
                          widget.isSelected ? FWT.semiBold : FWT.regular,
                    ),
                  ),
                  SizedBox(
                      width:
                          widget.isSelected && widget.chipType == ChipType.close
                              ? 10
                              : 0),
                  widget.isSelected && widget.chipType == ChipType.close
                      ? CustomSvgView(
                          imageUrl: AssetUtilities.closeStrokeSvg,
                          isFromAssets: true,
                          height: 8,
                          width: 8,
                          svgColor: ColorUtilities.primary_300,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        });
  }
}

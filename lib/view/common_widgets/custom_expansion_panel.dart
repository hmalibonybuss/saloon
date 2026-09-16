import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnExpandTile = void Function(bool);

class CustomExpansionPanel extends StatefulWidget {
  final String title;
  final String content;
  final OnExpandTile onExpandTile;

  CustomExpansionPanel({Key key, this.title, this.content, this.onExpandTile})
      : super(key: key);

  @override
  _CustomExpansionPanelState createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  bool isExpanded = false;

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              color: ColorUtilities.transparant,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title ?? '',
                            style: FontStyleUtilities.t1(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ),
                        CustomSvgView(
                          imageUrl: isExpanded
                              ? AssetUtilities.minusStrokeSvg
                              : AssetUtilities.plusStrokeSvg,
                          isFromAssets: true,
                          height: 20,
                          width: 20,
                          svgColor: _themeController.isDarkMode
                              ? ColorUtilities.dark_400
                              : ColorUtilities.text_300,
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: isExpanded,
                      child: Text(
                        widget.content ?? '',
                        style: FontStyleUtilities.p2(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.text_400
                              : ColorUtilities.text_500,
                          fontWeight: FWT.regular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

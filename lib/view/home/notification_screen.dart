import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/utilities/font_style_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeController>(
          init: _themeController,
          builder: (_) {
            return Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white,
              body: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Notifications',
                          style: FontStyleUtilities.h3(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            color: ColorUtilities.transparant,
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            child: CustomSvgView(
                              imageUrl: AssetUtilities.closeStrokeSvg,
                              isFromAssets: true,
                              height: 15,
                              width: 15,
                              svgColor: _themeController.isDarkMode
                                  ? ColorUtilities.dark_100
                                  : ColorUtilities.text_900,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Mark all as read',
                          style: FontStyleUtilities.t3(
                            fontColor: ColorUtilities.text_300,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Do not disturb',
                          style: FontStyleUtilities.t3(
                            fontColor: ColorUtilities.text_300,
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomSwitchButton(
                          onChange: (bool value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  NotificationTile(
                    themeController: _themeController,
                    isNew: true,
                    title:
                        "You have an appointment at The Galleria Hair Salon at 8:00 amtoday.",
                    date: "Just now",
                  ),
                  Divider(),
                  NotificationTile(
                    themeController: _themeController,
                    isNew: false,
                    title: "Your password is successfully changed",
                    date: "2 hous ago",
                  ),
                  Divider(),
                  NotificationTile(
                    themeController: _themeController,
                    isNew: false,
                    title:
                        "Completed your profile to be better health consults. Complete Profile",
                    date: "3 days ago",
                  ),
                  Divider(),
                ],
              ),
            );
          }),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final ThemeController _themeController;
  final bool isNew;
  final String title;
  final String date;

  const NotificationTile({
    Key key,
    @required ThemeController themeController,
    this.isNew = false,
    this.title,
    this.date,
  })  : _themeController = themeController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isNew
                  ? (_themeController.isDarkMode
                      ? ColorUtilities.primary_400
                      : ColorUtilities.primary_500)
                  : (_themeController.isDarkMode
                      ? ColorUtilities.dark_700
                      : ColorUtilities.text_100),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? '',
                  style: FontStyleUtilities.t3(
                    fontColor: _themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  date ?? '',
                  style: FontStyleUtilities.t5(
                    fontColor: _themeController.isDarkMode
                        ? ColorUtilities.text_500
                        : ColorUtilities.text_300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

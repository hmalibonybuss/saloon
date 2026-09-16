import 'package:flutter/material.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

enum ServiceTabTileType {
  active,
  inactive,
  error,
}

class ServiceTabTile extends StatelessWidget {
  final Map service;
  final ThemeController themeController;
  final VoidCallback onPress;
  const ServiceTabTile(
      {Key key, this.service, this.themeController, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
        height: 60,
        width: screenSize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: service['tileType'] == ServiceTabTileType.error
                ? ColorUtilities.red_500
                : service['tileType'] == ServiceTabTileType.active
                    ? ColorUtilities.primary_700
                    : ColorUtilities.transparant,
          ),
          color: themeController.isDarkMode
              ? ColorUtilities.dark_800
              : ColorUtilities.light_300,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              service['title'],
              style: FontStyleUtilities.t2(
                fontColor: service['tileType'] == ServiceTabTileType.active
                    ? ColorUtilities.primary_500
                    : (themeController.isDarkMode
                        ? ColorUtilities.text_400
                        : ColorUtilities.text_300),
                fontWeight: FWT.medium,
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  service['selectedServiceType'] ?? service['serviceTypes'],
                  style: FontStyleUtilities.t2(
                    fontColor: themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                    fontWeight: FWT.medium,
                  ),
                ),
                service['selectedServiceType'] != null
                    ? Text(
                        (service['selectedServiceType'] != null
                            ? ("+\$ " + service['selectedServiceAmt'])
                            : ''),
                        style: FontStyleUtilities.t2(
                          fontColor: ColorUtilities.primary_500,
                          fontWeight: FWT.medium,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            GestureDetector(
              onTap: onPress ?? () {},
              child: Container(
                color: ColorUtilities.transparant,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: CustomSvgView(
                  imageUrl: AssetUtilities.dropDownStrokeSvg,
                  isFromAssets: true,
                  height: 12,
                  width: 14,
                  svgColor: service['tileType'] == ServiceTabTileType.active
                      ? ColorUtilities.primary_500
                      : (themeController.isDarkMode
                          ? ColorUtilities.text_400
                          : ColorUtilities.text_300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

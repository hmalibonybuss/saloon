import 'package:flutter/material.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/utilities/font_style_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

class AboutTab extends StatelessWidget {
  final ThemeController themeController;

  const AboutTab(this.themeController, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Axe Hair salon is located in Houston, Virginia was formed in 2003. Opened with the premise of exceptional service for a fair price,Axe Hair salon is located in Houston, Virginia was formed in 2003. Opened with the premise of exceptional service for a fair price, Good',
            style: FontStyleUtilities.p1(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.text_600
                  : ColorUtilities.text_400,
            ),
            textAlign: TextAlign.justify,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            child: Text(
              'Read More',
              style: FontStyleUtilities.p1(
                fontColor: themeController.isDarkMode
                    ? ColorUtilities.primary_400
                    : ColorUtilities.text_600,
                fontWeight: FWT.medium,
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Opening Hours',
            style: FontStyleUtilities.t2(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.white
                  : ColorUtilities.text_900,
              fontWeight: FWT.semiBold,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              {
                "day": "Monday - Friday",
                "time": "8:30 am - 9:30 am",
              },
              {
                "day": "Monday - Friday",
                "time": "8:30 am - 9:30 am",
              },
            ]
                .map((e) => Row(
                      children: [
                        Text(
                          e['day'] ?? 'day',
                          style: FontStyleUtilities.t2(
                            fontColor: themeController.isDarkMode
                                ? ColorUtilities.text_400
                                : ColorUtilities.text_300,
                            fontWeight: FWT.regular,
                          ),
                        ),
                        Spacer(),
                        Text(
                          e['time'] ?? 'time',
                          style: FontStyleUtilities.t2(
                            fontColor: themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_600,
                            fontWeight: FWT.regular,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
          SizedBox(height: 25),
          Text(
            'Contact',
            style: FontStyleUtilities.t2(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.white
                  : ColorUtilities.text_900,
              fontWeight: FWT.semiBold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '583 463 23 34',
            style: FontStyleUtilities.t2(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.primary_400
                  : ColorUtilities.primary_700,
              fontWeight: FWT.regular,
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Address',
            style: FontStyleUtilities.t2(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.white
                  : ColorUtilities.text_900,
              fontWeight: FWT.semiBold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '6391 Elgin St. Celina, Delaware 10299',
            style: FontStyleUtilities.t2(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.text_400
                  : ColorUtilities.text_600,
              fontWeight: FWT.regular,
            ),
          ),
          SizedBox(height: 15),
          CustomImageView(
            imageUrl: AssetUtilities.saloonScreenMapPng,
            isFromAssets: true,
            height: 210,
            width: screenSize.width,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(30),
          ),
          SizedBox(height: 15),
          CustomButton(
            title: "Get directions - 4 km",
            preffixIcon: AssetUtilities.sendStrokeSvg,
            width: screenSize.width,
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class ServiceTypeCard extends StatelessWidget {
  final ServiceTypeModel service;
  final VoidCallback onPress;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  ServiceTypeCard({Key key, this.service, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return GestureDetector(
          onTap: onPress ?? () {},
          child: Container(
            height: 90,
            width: screenSize.width,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.light_300,
              border: Border.all(
                color: service.isSelected
                    ? ColorUtilities.primary_500
                    : ColorUtilities.transparant,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imageUrl: service.image,
                  isFromAssets: true,
                  radius: BorderRadius.circular(15),
                  height: 70,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        service.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyleUtilities.t1(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                      Text(
                        service.title != null
                            ? ((service.title ?? '') + " Booked")
                            : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyleUtilities.t3(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.text_400
                              : ColorUtilities.text_300,
                          fontWeight: FWT.regular,
                        ),
                      ),
                      Text(
                        service.amt != null
                            ? ("\$ " + (service.amt ?? ''))
                            : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyleUtilities.t3(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.primary_400
                              : ColorUtilities.primary_700,
                          fontWeight: FWT.regular,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: service.isSelected
                        ? ColorUtilities.primary_500
                        : ColorUtilities.light_900,
                  ),
                  alignment: Alignment.center,
                  child: service.isSelected
                      ? CustomSvgView(
                          imageUrl: AssetUtilities.checkTrueStrokeSvg,
                          isFromAssets: true,
                          height: 15,
                          width: 15,
                          svgColor: ColorUtilities.white,
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

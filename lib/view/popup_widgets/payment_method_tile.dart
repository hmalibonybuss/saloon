import 'package:flutter/material.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

enum PaymentTileType {
  addNew,
  showToSelect,
}

class PaymentMethodTile extends StatelessWidget {
  final ThemeController themeController;
  final String image;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final PaymentTileType paymentTileType;
  final Color activeTextColor;
  final Color inactiveTextColor;
  const PaymentMethodTile({
    Key key,
    this.themeController,
    this.image,
    this.name,
    this.isSelected,
    this.onTap,
    this.paymentTileType = PaymentTileType.showToSelect,
    this.activeTextColor,
    this.inactiveTextColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 60,
        width: screenSize.width,
        margin: EdgeInsets.symmetric(
            vertical: paymentTileType == PaymentTileType.addNew ? 0 : 7),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              paymentTileType == PaymentTileType.addNew ? 0 : 15),
          color: paymentTileType == PaymentTileType.addNew
              ? (themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white)
              : (themeController.isDarkMode
                  ? ColorUtilities.dark_800
                  : ColorUtilities.light_300),
          border: Border.all(
            color: isSelected
                ? ColorUtilities.primary_500
                : (paymentTileType == PaymentTileType.addNew
                    ? (themeController.isDarkMode
                        ? ColorUtilities.dark_800
                        : ColorUtilities.light_300)
                    : ColorUtilities.transparant),
          ),
        ),
        child: Row(
          children: [
            CustomImageView(
              imageUrl: image,
              isFromAssets: true,
              height: 25,
              width: 23,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 25),
            Expanded(
              child: Text(
                (name ?? ''),
                style: FontStyleUtilities.t2(
                  fontColor: isSelected
                      ? activeTextColor ?? ColorUtilities.primary_500
                      : inactiveTextColor ??
                          (themeController.isDarkMode
                              ? ColorUtilities.text_400
                              : ColorUtilities.text_300),
                ),
              ),
            ),
            paymentTileType == PaymentTileType.showToSelect
                ? Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? ColorUtilities.primary_500
                          : ColorUtilities.light_900,
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? CustomSvgView(
                            imageUrl: AssetUtilities.checkTrueStrokeSvg,
                            isFromAssets: true,
                            height: 8,
                            width: 8,
                            svgColor: ColorUtilities.white,
                          )
                        : SizedBox(),
                  )
                : CustomSvgView(
                    imageUrl: AssetUtilities.iosRightStrokeSvg,
                    isFromAssets: true,
                    height: 20,
                    width: 20,
                    svgColor: themeController.isDarkMode
                        ? ColorUtilities.dark_400
                        : ColorUtilities.text_300,
                  ),
          ],
        ),
      ),
    );
  }
}

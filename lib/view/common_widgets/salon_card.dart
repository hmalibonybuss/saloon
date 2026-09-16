import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

enum SalonCardTypes {
  showStars,
  showButton,
  showFavorite,
}

/// ignore: must_be_immutable
class SalonCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int rateStarsCount;
  final VoidCallback onCardPress;
  final VoidCallback onBook;
  final String distance;
  final double width;
  final VoidCallback onFavoriteTap;

  /// THIS "cardType" IS USED TO DEFINE TYPE OF CARD.
  /// YOU CAN USE SalonCardTypes.showStars TO SHOW DETAILS STARS
  /// YOU CAN USE SalonCardTypes.showButton TO GET ON TAP CALLBACK
  /// YOU CAN USE SalonCardTypes.showFavorite TO GET FAVORITE ICON
  final SalonCardTypes cardType;
  SalonCard({
    Key key,
    this.image,
    this.title,
    this.description,
    this.rateStarsCount,
    this.distance,
    this.cardType = SalonCardTypes.showStars,
    this.width,
    this.onBook,
    this.onFavoriteTap,
    this.onCardPress,
  }) {
    if (cardType == SalonCardTypes.showStars) {
    }

    if (cardType == SalonCardTypes.showButton) {
    }
  }

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onCardPress ?? () {},
      child: Container(
        height: 110,
        width: width ?? screenSize.width,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: _themeController.isDarkMode
              ? ColorUtilities.dark_800
              : ColorUtilities.light_200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CustomImageView(
              imageUrl: image ?? AssetUtilities.homeScreenNearestListPng,
              width: 95,
              height: 85,
              isFromAssets: true,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(20),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: FontStyleUtilities.t1(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      fontWeight: FWT.semiBold,
                    ),
                  ),
                  Text(
                    description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: FontStyleUtilities.t3(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.text_400
                          : ColorUtilities.text_300,
                      fontWeight: FWT.regular,
                    ),
                  ),
                  Row(
                    children: [
                      cardType != SalonCardTypes.showFavorite
                          ? getStars(_themeController,
                              isDetailed: cardType == SalonCardTypes.showStars,
                              starCount: rateStarsCount)
                          : SizedBox(),
                      cardType != SalonCardTypes.showFavorite
                          ? Spacer()
                          : SizedBox(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomSvgView(
                            imageUrl: AssetUtilities.mapPinStrokeSvg,
                            isFromAssets: true,
                            width: 10,
                            height: 11,
                            svgColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                          ),
                          SizedBox(width: 5),
                          Text(
                            distance ?? '',
                            style: FontStyleUtilities.t3(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.regular,
                            ),
                          ),
                        ],
                      ),
                      cardType != SalonCardTypes.showStars
                          ? Spacer()
                          : SizedBox(),
                      cardType == SalonCardTypes.showFavorite
                          ? CustomActionButton(
                              height: 30,
                              width: 30,
                              iconSize: 11,
                              radius: 7,
                              icon: AssetUtilities.heartSolidSvg,
                              color: ColorUtilities.red_500,
                              onTap: onFavoriteTap ?? () {},
                            )
                          : SizedBox(),
                      SizedBox(width: 10),
                      cardType != SalonCardTypes.showStars
                          ? CustomButton(
                              buttonSize: ButtonSize.small,
                              title: "Book",
                              onButtonTap: onBook ?? () {},
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

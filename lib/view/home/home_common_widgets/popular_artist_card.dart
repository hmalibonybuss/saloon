import 'package:flutter/material.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

enum PopularCardType {
  selectable,
  simple,
}

class PopularArtistsCard extends StatelessWidget {
  final String image;
  final String name;
  final String job;
  final VoidCallback onPress;
  final PopularCardType popularCardType;
  final bool isSelected;
  const PopularArtistsCard({
    Key key,
    @required ThemeController themeController,
    this.image,
    this.name,
    this.job,
    this.onPress,
    this.popularCardType = PopularCardType.simple,
    this.isSelected = false,
  })  : _themeController = themeController,
        super(key: key);

  final ThemeController _themeController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: ColorUtilities.transparant,
          border: Border.all(
            color: isSelected && popularCardType == PopularCardType.selectable
                ? ColorUtilities.primary_500
                : ColorUtilities.transparant,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
              isSelected && popularCardType == PopularCardType.selectable
                  ? 25
                  : 0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
              imageUrl: image,
              isFromAssets: true,
              height: 60,
              width: 60,
              radius: BorderRadius.circular(
                  popularCardType == PopularCardType.selectable ? 20 : 50),
            ),
            SizedBox(height: 5),
            Text(
              name,
              style: FontStyleUtilities.t3(
                fontColor:
                    isSelected && popularCardType == PopularCardType.selectable
                        ? ColorUtilities.primary_500
                        : (_themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900),
                fontWeight:
                    isSelected && popularCardType == PopularCardType.selectable
                        ? FWT.semiBold
                        : FWT.regular,
              ),
            ),
            Text(
              job,
              style: FontStyleUtilities.t5(
                fontColor: _themeController.isDarkMode
                    ? ColorUtilities.text_500
                    : ColorUtilities.text_200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

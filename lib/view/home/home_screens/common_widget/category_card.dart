import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  CategoryCard({
    Key key,
    this.image,
    this.title,
    this.onTap,
  }) : super(key: key);

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return GestureDetector(
            onTap: onTap ?? () {},
            child: Container(
              height: 140,
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imageUrl: image,
                    height: 100,
                    width: 100,
                    radius: BorderRadius.circular(25),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: FontStyleUtilities.t3(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.text_400
                          : ColorUtilities.text_700,
                      fontWeight: FWT.regular,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

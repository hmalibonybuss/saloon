import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/popup_widgets/package_details_popup.dart';

/// ignore: must_be_immutable
class PackageTab extends StatelessWidget {
  List<PackageModel> packageDataList = [
    PackageModel(
      title: "Bridal Beauty Makeup",
      subTitle: "Completed package offer till sep 18, 2021",
      description:
          "Women want ro feel  attractive. We offer timeless beauty package to accentuate their natural beauty so they can feel beautiful in every day.",
      amt: "280.30",
      image: AssetUtilities.packageImage1Png,
      services: [
        "HairStyling",
        "Nall",
        "Hair color",
        "Body growing",
        "Facial",
        "Spa",
        "Eyebrows",
        "Make up",
        "Retoch",
        "Corner Lashes",
      ],
    ),
    PackageModel(
      title: "Haircut & Hairstyle",
      subTitle: "Completed package offer till sep 24, 2021",
      description:
          "Women want ro feel  attractive. We offer timeless beauty package to accentuate their natural beauty so they can feel beautiful in every day.",
      amt: "160.45",
      image: AssetUtilities.packageImage2Png,
      services: [
        "HairStyling",
        "Nall",
        "Hair color",
        "Body growing",
        "Corner Lashes",
      ],
    ),
    PackageModel(
      title: "Bridal Beauty Makeup",
      subTitle: "Completed package offer till sep 18, 2021",
      description:
          "Women want ro feel  attractive. We offer timeless beauty package to accentuate their natural beauty so they can feel beautiful in every day.",
      amt: "280.30",
      image: AssetUtilities.packageImage3Png,
      services: [
        "HairStyling",
        "Nall",
        "Hair color",
        "Body growing",
        "Facial",
        "Spa",
        "Eyebrows",
        "Make up",
        "Retoch",
        "Corner Lashes",
        "Facial",
        "Spa",
        "Eyebrows",
        "Make up",
        "Retoch",
        "Corner Lashes",
      ],
    ),
    PackageModel(
      title: "Haircut & Hairstyle",
      subTitle: "Completed package offer till sep 18, 2021",
      description:
          "Women want ro feel  attractive. We offer timeless beauty package to accentuate their natural beauty so they can feel beautiful in every day.",
      amt: "160.45",
      image: AssetUtilities.packageImage4Png,
      services: [
        "HairStyling",
        "Nall",
        "Hair color",
        "Body growing",
        "Facial",
      ],
    ),
  ];

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: List.generate(
                packageDataList.length,
                (index) {
                  PackageModel package = packageDataList[index];
                  return Container(
                    width: screenSize.width,
                    height: 112,
                    decoration: BoxDecoration(
                      color: ColorUtilities.transparant,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        CustomImageView(
                          imageUrl: package.image,
                          isFromAssets: true,
                          height: 112,
                          width: 130,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(20),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyleUtilities.t1(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.white
                                      : ColorUtilities.text_900,
                                  fontWeight: FWT.semiBold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                package.subTitle ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyleUtilities.t3(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.text_400
                                      : ColorUtilities.text_300,
                                  fontWeight: FWT.regular,
                                ),
                              ),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    package.amt != null
                                        ? ("\$ " + package.amt ?? '')
                                        : '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FontStyleUtilities.t3(
                                      fontColor: ColorUtilities.primary_500,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                  Spacer(),
                                  CustomButton(
                                    title: "Book Now",
                                    buttonSize: ButtonSize.small,
                                    onButtonTap: () {
                                      Get.bottomSheet(PackageDetailsPopup(
                                        package: package,
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

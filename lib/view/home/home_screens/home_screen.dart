import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/home/home_screen/category_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/favorite/favorite_screen.dart';
import 'package:saloon_app/view/home/appointment_screens/book_appointment_screen.dart';
import 'package:saloon_app/view/home/home_screens/common_widget/home_common_widgets.dart';
import 'package:saloon_app/view/home/notification_screen.dart';
import 'package:saloon_app/view/home/search_screen.dart';
import 'package:saloon_app/view/saloon_details/saloon_details_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final VoidCallback openProfile;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<CategoryModel> homeScreenCategoryDataList = [
    CategoryModel(
      title: "Haircuts",
      image: AssetUtilities.homeScreenHairCutsPng,
    ),
    CategoryModel(
      title: "Make up",
      image: AssetUtilities.homeScreenMakeUpPng,
    ),
    CategoryModel(
      title: "Manicure",
      image: AssetUtilities.homeScreenManicurePng,
    ),
    CategoryModel(
      title: "Message",
      image: AssetUtilities.homeScreenMessagePng,
    ),
  ];

  HomeScreen({Key key, this.openProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Scaffold(
          backgroundColor: _themeController.isDarkMode
              ? ColorUtilities.dark_900
              : ColorUtilities.white,
          body: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: openProfile ?? () {},
                      child: Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        child: CustomImageView(
                          imageUrl: AssetUtilities.homeScreenProfilePng,
                          isFromAssets: true,
                          width: 45,
                          height: 45,
                          radius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Spacer(),
                    CustomActionButton(
                      icon: _themeController.isDarkMode
                          ? AssetUtilities.bellDotWStrokeSvg
                          : AssetUtilities.bellDotStrokeSvg,
                      takeDefaultColor: true,
                      onTap: () {
                        Get.to(NotificationScreen());
                      },
                    ),
                    SizedBox(width: 10),
                    CustomActionButton(
                      icon: AssetUtilities.heartStrokeSvg,
                      color: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      onTap: () {
                        Get.to(FavoriteScreen());
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Hi, Robert Fox',
                          style: FontStyleUtilities.h4(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomSvgView(
                              imageUrl: AssetUtilities.mapPinStrokeSvg,
                              isFromAssets: true,
                              height: 12,
                              width: 12,
                              svgColor: _themeController.isDarkMode
                                  ? ColorUtilities.text_400
                                  : ColorUtilities.text_300,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '6391 Elgin St. Celina, Delaware 10299',
                              style: FontStyleUtilities.t3(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.text_400
                                    : ColorUtilities.text_300,
                                fontWeight: FWT.regular,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomSearchbar(
                          hintText: "Search by Salon",
                          onSearchActionTap: () {
                            Get.to(SearchScreen());
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Row(
                              children: homeScreenCategoryDataList
                                  .map((CategoryModel e) => CategoryCard(
                                        image: e.image,
                                        title: e.title,
                                        onTap: () {
                                          Get.to(BookAppointmentScreen());
                                        },
                                      ))
                                  .toList(),
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: VoucherCard(
                          percentage: "-40%",
                          message: "Voucher for your next haircut service",
                          image: AssetUtilities.homeScreenVoucherPng,
                          onTap: () {
                            Get.to(BookAppointmentScreen());
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nearest salon",
                              style: FontStyleUtilities.h5(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                            Text(
                              "View All",
                              style: FontStyleUtilities.t3(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.text_500
                                    : ColorUtilities.text_300,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            SalonCard(
                              image: AssetUtilities.homeScreenNearestListPng,
                              title: 'Bella Rinova',
                              description:
                                  '6391 Elgin St. Celina, Delaware, New York',
                              cardType: SalonCardTypes.showStars,
                              rateStarsCount: 4,
                              distance: "5 km",
                              onCardPress: () {
                                Get.to(SaloonDetailsScreen(
                                  isOpen: true,
                                ));
                              },
                            ),
                            SalonCard(
                              image: AssetUtilities.homeScreenNearestListPng,
                              title: 'Bella Rinova',
                              description:
                                  '6391 Elgin St. Celina, Delaware, New York',
                              cardType: SalonCardTypes.showStars,
                              rateStarsCount: 5,
                              distance: "25 km",
                              onCardPress: () {
                                Get.to(SaloonDetailsScreen(
                                  isOpen: false,
                                ));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

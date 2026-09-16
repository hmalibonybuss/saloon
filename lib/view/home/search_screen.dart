import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/home/search_screen_artist_model.dart';
import 'package:saloon_app/model/home/search_screen_category_model.dart';
import 'package:saloon_app/model/home/search_screen_recent_found_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/book_appointment_screen.dart';
import 'package:saloon_app/view/home/filter_screen/filter_screen.dart';
import 'package:saloon_app/view/home/home_common_widgets/home_common_widgets.dart';
import 'package:saloon_app/view/saloon_details/saloon_details_screen.dart';
import 'package:saloon_app/view/saloon_details/saloon_specialist.dart';

/// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<SearchScreenCategoryModel> searchScreenCategoryList = [
    SearchScreenCategoryModel(
      title: "All",
      isSelected: true,
      index: 1,
    ),
    SearchScreenCategoryModel(
      title: "Haircuts",
      isSelected: false,
      index: 2,
    ),
    SearchScreenCategoryModel(
      title: "Make up",
      isSelected: false,
      index: 3,
    ),
    SearchScreenCategoryModel(
      title: "Message",
      isSelected: false,
      index: 4,
    ),
    SearchScreenCategoryModel(
      title: "Skin care",
      isSelected: false,
      index: 5,
    ),
    SearchScreenCategoryModel(
      title: "Make up",
      isSelected: false,
      index: 6,
    ),
    SearchScreenCategoryModel(
      title: "Message",
      isSelected: false,
      index: 7,
    ),
    SearchScreenCategoryModel(
      title: "Skin care",
      isSelected: false,
      index: 8,
    ),
  ];

  List<SearchScreenArtistModel> searchScreenArtistList = [
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenLilyPng,
      name: "Lily",
      job: "Hair Stylist",
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenLeePng,
      name: "Lee",
      job: "Sx Barber",
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenConnorPng,
      name: "Connor",
      job: "Makeup Artist",
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenJasonPng,
      name: "Jason",
      job: "Hair Stylist",
    ),
    SearchScreenArtistModel(
      image: AssetUtilities.searchScreenMikePng,
      name: "Mike",
      job: "Sx Barber",
    ),
  ];

  List<SearchScreenRecentFoundModel> searchScreenRecentDataList = [
    SearchScreenRecentFoundModel(
      image: AssetUtilities.searchScreenRF01Png,
      name: "Green Apple",
      address: "6391 Elgin St. Celina, Delaware",
      star: 5,
      distance: "15 km",
    ),
    SearchScreenRecentFoundModel(
      image: AssetUtilities.searchScreenRF02Png,
      name: "Bella Rinova",
      address: "8502 Preston Rd. Inglewood",
      star: 4,
      distance: "25 km",
    ),
    SearchScreenRecentFoundModel(
      image: AssetUtilities.searchScreenRF03Png,
      name: "The Galleria",
      address: "4140 Parker Rd. Allentown",
      star: 3,
      distance: "48 km",
    ),
    SearchScreenRecentFoundModel(
      image: AssetUtilities.searchScreenRF04Png,
      name: "Michael Saldana",
      address: "3891 Ranchview Dr. Richardson",
      star: 4,
      distance: "89 km",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Scaffold(
          backgroundColor: _themeController.isDarkMode
              ? ColorUtilities.dark_900
              : ColorUtilities.white,
          body: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSearchbar(
                      hintText: "Search by Salon",
                      width: screenSize.width - 100,
                      onSearchActionTap: () {
                        Get.to(FilterScreen());
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: ColorUtilities.transparant,
                        padding: EdgeInsets.all(10.0),
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
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: searchScreenCategoryList
                                  .map((SearchScreenCategoryModel e) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            searchScreenCategoryList
                                                .forEach((element) {
                                              element.isSelected = false;
                                            });
                                            int categoryIndex =
                                                searchScreenCategoryList
                                                    .indexWhere(
                                                        (SearchScreenCategoryModel
                                                                element) =>
                                                            element.index ==
                                                            e.index);
                                            searchScreenCategoryList[
                                                    categoryIndex]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Container(
                                          color: ColorUtilities.transparant,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.title,
                                                style: FontStyleUtilities.t3(
                                                  fontColor: e.isSelected
                                                      ? (_themeController
                                                              .isDarkMode
                                                          ? ColorUtilities.white
                                                          : ColorUtilities
                                                              .text_900)
                                                      : (_themeController
                                                              .isDarkMode
                                                          ? ColorUtilities
                                                              .text_500
                                                          : ColorUtilities
                                                              .text_100),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              e.isSelected
                                                  ? Container(
                                                      height: 2,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorUtilities
                                                            .primary_500,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Popular artist',
                          style: FontStyleUtilities.h5(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: searchScreenArtistList
                                  .map(
                                    (SearchScreenArtistModel e) =>
                                        PopularArtistsCard(
                                      themeController: _themeController,
                                      image: e.image,
                                      job: e.job,
                                      name: e.name,
                                      onPress: () {
                                        Get.to(SaloonSpecialist());
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Result Found (246)',
                          style: FontStyleUtilities.h5(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: searchScreenRecentDataList
                              .map(
                                  (SearchScreenRecentFoundModel e) => SalonCard(
                                        cardType: SalonCardTypes.showButton,
                                        image: e.image,
                                        title: e.name,
                                        description: e.address,
                                        rateStarsCount: e.star,
                                        distance: e.distance,
                                        onCardPress: () {
                                          Get.to(SaloonDetailsScreen(
                                            isOpen: false,
                                          ));
                                        },
                                        onBook: () {
                                          Get.to(BookAppointmentScreen());
                                        },
                                      ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

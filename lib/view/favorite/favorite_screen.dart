import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/utilities/font_style_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/book_appointment_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  PageController _pageController;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<Map> favoriteTabList = [
    {
      "title": "All",
      "isSelected": true,
    },
    {
      "title": "Haircts",
      "isSelected": false,
    },
    {
      "title": "Make up",
      "isSelected": false,
    },
    {
      "title": "Massage",
      "isSelected": false,
    },
    {
      "title": "Skin care",
      "isSelected": false,
    },
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white,
              body: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Favorite',
                          style: FontStyleUtilities.h3(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            color: ColorUtilities.transparant,
                            child: CustomSvgView(
                              imageUrl: AssetUtilities.closeStrokeSvg,
                              isFromAssets: true,
                              height: 13,
                              width: 13,
                              svgColor: _themeController.isDarkMode
                                  ? ColorUtilities.dark_100
                                  : ColorUtilities.text_900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 25),
                        Row(
                          children: List.generate(
                            favoriteTabList.length,
                            (index) {
                              Map item = favoriteTabList[index];
                              return CommonChip(
                                title: item['title'],
                                radius: 30,
                                isSelected: item['isSelected'],
                                chipType: ChipType.simple,
                                activeColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                inactiveColor: ColorUtilities.transparant,
                                onChipTap: (bool isSelected) {
                                  setState(() {
                                    favoriteTabList.forEach((element) {
                                      element['isSelected'] = false;
                                    });
                                    favoriteTabList[index]['isSelected'] =
                                        isSelected;
                                  });
                                  _pageController.jumpToPage(index);
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        getAllData(tabDataList: [1, 2, 3, 4, 5, 6, 7, 8]),
                        getAllData(tabDataList: [1, 2, 3]),
                        getAllData(tabDataList: [1, 2, 3, 4]),
                        getAllData(tabDataList: [1]),
                        getAllData(tabDataList: [1, 2]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Get Data for Tab
  Widget getAllData({@required List tabDataList}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: tabDataList
              .map(
                (e) => SalonCard(
                  image: AssetUtilities.homeScreenNearestListPng,
                  title: 'Bella Rinova',
                  description: '6391 Elgin St. Celina, Delaware, New York',
                  cardType: SalonCardTypes.showFavorite,
                  rateStarsCount: 5,
                  distance: "25 KM",
                  onFavoriteTap: () {},
                  onBook: () {
                    Get.to(BookAppointmentScreen());
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

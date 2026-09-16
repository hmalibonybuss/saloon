import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/home/filter_screen_service_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/filter_screen/custom_round_slider_thumb_shape.dart';
import 'package:saloon_app/view/home/home.dart';

enum FilterType {
  sortBy,
  filter,
}

/// ignore: must_be_immutable
class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<FilterScreenServiceModel> filterScreenServiceList = [
    FilterScreenServiceModel(
      title: "Haricuts",
      isSelected: true,
      index: 1,
    ),
    FilterScreenServiceModel(
      title: "Make up",
      isSelected: true,
      index: 2,
    ),
    FilterScreenServiceModel(
      title: "Manicure",
      isSelected: true,
      index: 3,
    ),
    FilterScreenServiceModel(
      title: "Haricuts",
      isSelected: true,
      index: 4,
    ),
    FilterScreenServiceModel(
      title: "Make up",
      isSelected: true,
      index: 5,
    ),
  ];

  List<Map> genderList = [
    {
      "title": "All",
      "isSelected": true,
    },
    {
      "title": "Man",
      "isSelected": false,
    },
    {
      "title": "Woman",
      "isSelected": false,
    },
  ];

  FilterType selectedFilterType = FilterType.filter;
  int selectedStars = 1;
  double selectedDistance = 10;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        final Size screenSize = MediaQuery.of(context).size;
        return WillPopScope(
          onWillPop: () async {
            Get.offAll(Home(
              homeSelectedPageIndex: 0,
            ));
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_700
                  : ColorUtilities.text_100,
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment(1, -1),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CustomSvgView(
                          imageUrl: AssetUtilities.closeStrokeSvg,
                          isFromAssets: true,
                          height: 16,
                          width: 16,
                          svgColor: _themeController.isDarkMode
                              ? ColorUtilities.dark_100
                              : ColorUtilities.text_900,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: (screenSize.height - 120),
                      width: screenSize.width,
                      decoration: BoxDecoration(
                          color: _themeController.isDarkMode
                              ? ColorUtilities.dark_800
                              : ColorUtilities.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -10),
                              color: _themeController.isDarkMode
                                  ? ColorUtilities.white.withOpacity(0.2)
                                  : ColorUtilities.dark_900.withOpacity(0.2),
                              blurRadius: 30,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (selectedFilterType != FilterType.sortBy) {
                                setState(() {
                                  selectedFilterType = FilterType.sortBy;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: screenSize.width,
                                  color: ColorUtilities.transparant,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomSvgView(
                                        imageUrl:
                                            AssetUtilities.layersStrokeSvg,
                                        isFromAssets: true,
                                        width: 18,
                                        height: 18,
                                        svgColor: _themeController.isDarkMode
                                            ? ColorUtilities.white
                                            : ColorUtilities.text_900,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Sort By',
                                        style: FontStyleUtilities.h5(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.white
                                              : ColorUtilities.text_900,
                                          fontWeight: FWT.semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Container(
                                    width: screenSize.width,
                                    child: Text(
                                      'Services:',
                                      style: FontStyleUtilities.t1(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.white
                                            : ColorUtilities.text_900,
                                        fontWeight: FWT.semiBold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: screenSize.width,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 25),
                                        Row(
                                          children: List.generate(
                                            filterScreenServiceList.length,
                                            (index) {
                                              FilterScreenServiceModel service =
                                                  filterScreenServiceList[
                                                      index];
                                              return CommonChip(
                                                title: service.title,
                                                isSelected: service.isSelected,
                                                chipType: ChipType.close,
                                                onChipTap: (bool isSelected) {
                                                  setState(() {
                                                    filterScreenServiceList[
                                                                index]
                                                            .isSelected =
                                                        isSelected;
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Container(
                                    width: screenSize.width,
                                    child: Text(
                                      'Rating:',
                                      style: FontStyleUtilities.t1(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.white
                                            : ColorUtilities.text_900,
                                        fontWeight: FWT.semiBold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    children: [
                                      getStars(
                                        _themeController,
                                        isDetailed: true,
                                        onRateChange: (int stars) {
                                          setState(() {
                                            selectedStars = stars;
                                          });
                                        },
                                        starCount: selectedStars,
                                        size: Size(17, 19),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        '$selectedStars' + '.0 Stars',
                                        style: FontStyleUtilities.t2(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.white
                                              : ColorUtilities.text_900,
                                          fontWeight: FWT.regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(
                          milliseconds: selectedFilterType != FilterType.filter
                              ? 500
                              : 300),
                      curve: selectedFilterType != FilterType.filter
                          ? Curves.easeInBack
                          : Curves.decelerate,
                      height: selectedFilterType != FilterType.filter
                          ? 80
                          : (screenSize.height - 200),
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: _themeController.isDarkMode
                            ? ColorUtilities.dark_900
                            : ColorUtilities.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -10),
                            color: _themeController.isDarkMode
                                ? ColorUtilities.white.withOpacity(0.1)
                                : ColorUtilities.dark_900.withOpacity(0.1),
                            blurRadius: 30,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (selectedFilterType != FilterType.filter) {
                                setState(() {
                                  selectedFilterType = FilterType.filter;
                                });
                              }
                            },
                            child: Container(
                              height: 80,
                              width: screenSize.width,
                              color: ColorUtilities.transparant,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSvgView(
                                    imageUrl: AssetUtilities.filterStrokeSvg,
                                    isFromAssets: true,
                                    width: 18,
                                    height: 18,
                                    svgColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Filter',
                                    style: FontStyleUtilities.h5(
                                      fontColor: _themeController.isDarkMode
                                          ? ColorUtilities.white
                                          : ColorUtilities.text_900,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Container(
                                      width: screenSize.width,
                                      child: Text(
                                        'Services:',
                                        style: FontStyleUtilities.t1(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.white
                                              : ColorUtilities.text_900,
                                          fontWeight: FWT.semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: screenSize.width,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 25),
                                          Row(
                                            children: List.generate(
                                              filterScreenServiceList.length,
                                              (index) {
                                                FilterScreenServiceModel
                                                    service =
                                                    filterScreenServiceList[
                                                        index];
                                                return CommonChip(
                                                  title: service.title,
                                                  isSelected:
                                                      service.isSelected,
                                                  chipType: ChipType.close,
                                                  onChipTap: (bool isSelected) {
                                                    setState(() {
                                                      filterScreenServiceList[
                                                                  index]
                                                              .isSelected =
                                                          isSelected;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Container(
                                      width: screenSize.width,
                                      child: Text(
                                        'Rating:',
                                        style: FontStyleUtilities.t1(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.white
                                              : ColorUtilities.text_900,
                                          fontWeight: FWT.semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      children: [
                                        getStars(
                                          _themeController,
                                          isDetailed: true,
                                          onRateChange: (int stars) {
                                            setState(() {
                                              selectedStars = stars;
                                            });
                                          },
                                          starCount: selectedStars,
                                          size: Size(17, 19),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          '$selectedStars' + '.0 Stars',
                                          style: FontStyleUtilities.t2(
                                            fontColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.white
                                                    : ColorUtilities.text_900,
                                            fontWeight: FWT.regular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Container(
                                      width: screenSize.width,
                                      child: Text(
                                        'Gender:',
                                        style: FontStyleUtilities.t1(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.white
                                              : ColorUtilities.text_900,
                                          fontWeight: FWT.semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    width: screenSize.width,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 25),
                                          Row(
                                            children: List.generate(
                                              genderList.length,
                                              (index) {
                                                Map gender = genderList[index];
                                                return CommonChip(
                                                  activeTextColor:
                                                      ColorUtilities.white,
                                                  inactiveTextColor:
                                                      _themeController
                                                              .isDarkMode
                                                          ? ColorUtilities
                                                              .text_500
                                                          : ColorUtilities
                                                              .text_900,
                                                  title: gender['title'],
                                                  isSelected:
                                                      gender['isSelected'],
                                                  chipType: ChipType.simple,
                                                  onChipTap: (bool isSelected) {
                                                    setState(() {
                                                      genderList
                                                          .forEach((element) {
                                                        element['isSelected'] =
                                                            false;
                                                      });
                                                      genderList[index]
                                                              ['isSelected'] =
                                                          isSelected;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Container(
                                      width: screenSize.width,
                                      child: Text(
                                        'Distance:',
                                        style: FontStyleUtilities.t1(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.white
                                              : ColorUtilities.text_900,
                                          fontWeight: FWT.semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SliderTheme(
                                    data: SliderThemeData(
                                        thumbShape: CustomRoundSliderThumbShape(
                                            backgroundColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.dark_900
                                                    : ColorUtilities.white,
                                            distanceText:
                                                "${selectedDistance.toInt()} KM")),
                                    child: Slider(
                                      value: selectedDistance,
                                      onChanged: (double value) {
                                        setState(() {
                                          selectedDistance = value;
                                        });
                                      },
                                      activeColor: ColorUtilities.primary_500,
                                      inactiveColor: _themeController.isDarkMode
                                          ? ColorUtilities.dark_800
                                          : ColorUtilities.primary_050,
                                      min: 1,
                                      max: 100,
                                    ),
                                  ),
                                  SizedBox(height: 80),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: CustomButton(
                                      preffixIcon:
                                          AssetUtilities.checkTrueStrokeSvg,
                                      title: "Apply Filters(4)",
                                      width: screenSize.width,
                                      onButtonTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

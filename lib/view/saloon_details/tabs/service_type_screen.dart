import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/saloon_details/tabs/service_type_card.dart';

typedef OnServiceSelect = void Function(String, String);

// ignore: must_be_immutable
class ServiceTypeScreen extends StatefulWidget {
  final OnServiceSelect onSelect;

  const ServiceTypeScreen({Key key, this.onSelect}) : super(key: key);
  @override
  _ServiceTypeScreenState createState() => _ServiceTypeScreenState();
}

class _ServiceTypeScreenState extends State<ServiceTypeScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  PageController _pageController;

  List<Map> genderTabList = [
    {
      "title": "Man",
      "isSelected": true,
    },
    {
      "title": "Woman",
      "isSelected": false,
    },
  ];

  List<ServiceTypeModel> serviceTypesList = [
    ServiceTypeModel(
        title: "Temple fade",
        bookedQty: "1023",
        amt: "5.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabTempleFadePng),
    ServiceTypeModel(
        title: "Undercut",
        bookedQty: "708",
        amt: "6.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabUnderCutPng),
    ServiceTypeModel(
        title: "Regular haircut",
        bookedQty: "669",
        amt: "5.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabRegularHairCutPng),
    ServiceTypeModel(
        title: "Quiff",
        bookedQty: "356",
        amt: "6.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabQuiffCutPng),
    ServiceTypeModel(
        title: "Crew cut",
        bookedQty: "213",
        amt: "5.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabCrewCutPng),
    ServiceTypeModel(
        title: "Comb over",
        bookedQty: "209",
        amt: "6.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabCombOverPng),
  ];

  List<ServiceTypeModel> serviceTypeListFemale = [
    ServiceTypeModel(
        title: "Comb over",
        bookedQty: "209",
        amt: "6.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabCombOverPng),
    ServiceTypeModel(
        title: "Regular haircut",
        bookedQty: "669",
        amt: "5.00",
        isSelected: false,
        image: AssetUtilities.serviceTypeTabRegularHairCutPng),
  ];

  int selectedServiceIndex;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: GetBuilder<ThemeController>(
          init: _themeController,
          builder: (_) {
            return Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            genderTabList.length,
                            (index) {
                              Map gender = genderTabList[index];
                              return CommonChip(
                                title: gender['title'],
                                radius: 30,
                                isSelected: gender['isSelected'],
                                chipType: ChipType.simple,
                                activeColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                inactiveColor: ColorUtilities.transparant,
                                onChipTap: (bool isSelected) {
                                  setState(() {
                                    genderTabList.forEach((element) {
                                      element['isSelected'] = false;
                                    });
                                    genderTabList[index]['isSelected'] =
                                        isSelected;
                                  });
                                  _pageController.jumpToPage(index);
                                },
                              );
                            },
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
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
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: List.generate(
                                serviceTypesList.length,
                                (index) {
                                  ServiceTypeModel service =
                                      serviceTypesList[index];
                                  return ServiceTypeCard(
                                    service: service,
                                    onPress: () {
                                      setState(() {
                                        if (serviceTypesList[index]
                                                .isSelected ==
                                            false) {
                                          serviceTypesList.forEach((element) {
                                            element.isSelected = false;
                                          });
                                          serviceTypesList[index].isSelected =
                                              true;
                                          selectedServiceIndex = index;
                                        } else {
                                          serviceTypesList.forEach((element) {
                                            element.isSelected = false;
                                          });
                                          selectedServiceIndex = null;
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: List.generate(
                                serviceTypeListFemale.length,
                                (index) {
                                  ServiceTypeModel service =
                                      serviceTypeListFemale[index];
                                  return ServiceTypeCard(
                                    service: service,
                                    onPress: () {
                                      setState(() {
                                        if (serviceTypesList[index]
                                                .isSelected ==
                                            false) {
                                          serviceTypeListFemale
                                              .forEach((element) {
                                            element.isSelected = false;
                                          });
                                          serviceTypeListFemale[index]
                                              .isSelected = true;
                                          selectedServiceIndex = index;
                                        } else {
                                          serviceTypeListFemale
                                              .forEach((element) {
                                            element.isSelected = false;
                                          });
                                          selectedServiceIndex = null;
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      title: "Done",
                      width: screenSize.width,
                      onButtonTap: () {
                        String serviceType =
                            serviceTypesList[selectedServiceIndex].title;
                        String serviceAmt =
                            serviceTypesList[selectedServiceIndex].amt;

                        widget.onSelect(serviceType, serviceAmt);
                                              Get.back();
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

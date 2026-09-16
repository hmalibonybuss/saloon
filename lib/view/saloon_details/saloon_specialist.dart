import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/home/search_screen_artist_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/view/home/appointment_screens/book_appointment_screen.dart';

class SaloonSpecialist extends StatefulWidget {
  @override
  _SaloonSpecialistState createState() => _SaloonSpecialistState();
}

class _SaloonSpecialistState extends State<SaloonSpecialist> {
  ScrollController _scrollController;
  PageController _pageController;
  PageController _tabPageController;
  double currentPosition = 0.0;
  int selectedPage = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: selectedPage);
    _tabPageController = PageController(initialPage: selectedPage);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        currentPosition = _scrollController.offset;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  bool isFavorite = false;

  List<SearchScreenArtistModel> detailsScreenList = [
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

  List<Map> saloonSpecialistDetailsList = [
    {
      "title": "Gallery",
      "isSelected": true,
    },
    {
      "title": "Portfolio",
      "isSelected": false,
    },
    {
      "title": "Review",
      "isSelected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 250,
                    backgroundColor: _themeController.isDarkMode
                        ? ColorUtilities.dark_900
                        : ColorUtilities.white,
                    automaticallyImplyLeading: false,
                    flexibleSpace: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints cnst) {
                        if (cnst.biggest.height > 70) {
                          return Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: screenSize.height / 3,
                                  width: screenSize.width,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: 3,
                                    onPageChanged: (int currentPageIndex) {
                                      setState(() {
                                        selectedPage = currentPageIndex;
                                      });
                                    },
                                    itemBuilder: (context, index) =>
                                        CustomImageView(
                                      imageUrl: AssetUtilities
                                          .saloonScreenMainImagePng,
                                      isFromAssets: true,
                                      fit: BoxFit.cover,
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: (cnst.biggest.height) > 100
                                      ? 30
                                      : (cnst.biggest.height) - 70,
                                  width: screenSize.width,
                                  decoration: BoxDecoration(
                                    color: _themeController.isDarkMode
                                        ? ColorUtilities.dark_900
                                        : ColorUtilities.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: screenSize.height / 3,
                                  width: screenSize.width,
                                  child: Opacity(
                                    opacity: (cnst.biggest.height) > 100
                                        ? 0
                                        : (1 -
                                            ((((cnst.biggest.height) - 70) *
                                                    1) /
                                                30)),
                                    child: Container(
                                      color: _themeController.isDarkMode
                                          ? ColorUtilities.dark_900
                                          : ColorUtilities.white,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0, -0.9),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    children: [
                                      BackArrow(
                                        onBackTap: () {
                                          Get.back();
                                        },
                                        color: ColorUtilities.white,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isFavorite = !isFavorite;
                                          });
                                        },
                                        child: CustomSvgView(
                                          imageUrl: isFavorite
                                              ? AssetUtilities.heartSolidSvg
                                              : AssetUtilities.heartStrokeSvg,
                                          isFromAssets: true,
                                          svgColor: ColorUtilities.white,
                                          height: 19,
                                          width: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Container(
                          decoration: BoxDecoration(
                            color: _themeController.isDarkMode
                                ? ColorUtilities.dark_900
                                : ColorUtilities.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imageUrl: AssetUtilities.searchScreenLilyPng,
                                isFromAssets: true,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                                radius: BorderRadius.circular(60),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Kathryn Murphy',
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
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                                child: CustomSvgView(
                                  imageUrl: isFavorite
                                      ? AssetUtilities.heartSolidSvg
                                      : AssetUtilities.heartStrokeSvg,
                                  isFromAssets: true,
                                  svgColor: ColorUtilities.dark_900,
                                  height: 19,
                                  width: 22,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Container(
                          color: _themeController.isDarkMode
                              ? ColorUtilities.dark_900
                              : ColorUtilities.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 25, right: 15, top: 0, bottom: 0),
                                    alignment: Alignment.center,
                                    child: CustomImageView(
                                      imageUrl:
                                          AssetUtilities.searchScreenLilyPng,
                                      isFromAssets: true,
                                      fit: BoxFit.cover,
                                      height: 90,
                                      width: 90,
                                      radius: BorderRadius.circular(60),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 25,
                                              top: 0,
                                              bottom: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Kathryn Murphy',
                                                style: FontStyleUtilities.h3(
                                                  fontColor: _themeController
                                                          .isDarkMode
                                                      ? ColorUtilities.white
                                                      : ColorUtilities.text_900,
                                                  fontWeight: FWT.semiBold,
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Hair Stylist at ',
                                                  style: FontStyleUtilities.t3(
                                                    fontColor: _themeController
                                                            .isDarkMode
                                                        ? ColorUtilities
                                                            .text_400
                                                        : ColorUtilities
                                                            .text_500,
                                                    fontWeight: FWT.regular,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Bella Rinova',
                                                  style: FontStyleUtilities.t3(
                                                    fontColor: _themeController
                                                            .isDarkMode
                                                        ? ColorUtilities
                                                            .primary_400
                                                        : ColorUtilities
                                                            .primary_700,
                                                    fontWeight: FWT.regular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              getStars(
                                                _themeController,
                                                isDetailed: true,
                                                starCount: 4,
                                                size: Size(14, 12),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '(25 Reviews)',
                                                style: FontStyleUtilities.t2(
                                                  fontColor: _themeController
                                                          .isDarkMode
                                                      ? ColorUtilities.text_500
                                                      : ColorUtilities.text_300,
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          {
                                            "icon":
                                                AssetUtilities.messageStrokeSvg,
                                            "title": "Chat",
                                            "onTap": () {},
                                          },
                                          {
                                            "icon":
                                                AssetUtilities.phoneStrokeSvg,
                                            "title": "Call",
                                            "onTap": () {},
                                          },
                                          {
                                            "icon":
                                                AssetUtilities.videoStrokeSvg,
                                            "title": "Video",
                                            "onTap": () {},
                                          },
                                        ]
                                            .map((e) => Expanded(
                                                  child: GestureDetector(
                                                    onTap: e['onTap'] ?? () {},
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 30, 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomSvgView(
                                                            imageUrl: e['icon'],
                                                            isFromAssets: true,
                                                            height: 20,
                                                            width: 20,
                                                            svgColor: _themeController
                                                                    .isDarkMode
                                                                ? ColorUtilities
                                                                    .dark_100
                                                                : ColorUtilities
                                                                    .text_900,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            e['title'],
                                                            style:
                                                                FontStyleUtilities
                                                                    .t3(
                                                              fontColor: _themeController
                                                                      .isDarkMode
                                                                  ? ColorUtilities
                                                                      .text_400
                                                                  : ColorUtilities
                                                                      .text_900,
                                                              fontWeight:
                                                                  FWT.regular,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CustomButton(
                                      title: "Book",
                                      buttonSize: ButtonSize.medium,
                                      width: 100,
                                      onButtonTap: () {
                                        Get.to(BookAppointmentScreen());
                                      },
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Axe Hair salon is located in Houston, Virginia was formed in 2003. Opened with the premise of exceptional service for a fair price,Axe Hair salon is located in Houston, Virginia was formed in 2003. Opened with the premise of exceptional service for a fair price, Good',
                                      style: FontStyleUtilities.p1(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.text_600
                                            : ColorUtilities.text_400,
                                      ),
                                      textAlign: TextAlign.justify,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        'Read More',
                                        style: FontStyleUtilities.p1(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.primary_400
                                              : ColorUtilities.text_600,
                                          fontWeight: FWT.medium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(width: 25),
                                    Row(
                                      children: List.generate(
                                        saloonSpecialistDetailsList.length,
                                        (index) {
                                          Map service =
                                              saloonSpecialistDetailsList[
                                                  index];
                                          return CommonChip(
                                            title: service['title'],
                                            radius: 30,
                                            isSelected: service['isSelected'],
                                            chipType: ChipType.simple,
                                            activeColor:
                                                _themeController.isDarkMode
                                                    ? ColorUtilities.white
                                                    : ColorUtilities.text_900,
                                            inactiveColor:
                                                ColorUtilities.transparant,
                                            onChipTap: (bool isSelected) {
                                              setState(() {
                                                saloonSpecialistDetailsList
                                                    .forEach((element) {
                                                  element['isSelected'] = false;
                                                });
                                                saloonSpecialistDetailsList[
                                                        index]['isSelected'] =
                                                    isSelected;
                                              });
                                              _tabPageController
                                                  .jumpToPage(index);
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
                              ExpandablePageView(
                                controller: _tabPageController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  GalleryTab(),
                                  Container(),
                                  Container(),
                                ],
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
          );
        });
  }
}

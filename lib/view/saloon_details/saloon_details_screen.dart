import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/home/search_screen_artist_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/home_common_widgets/home_common_widgets.dart';
import 'package:saloon_app/model/saloon_details/saloon_details.dart';
import 'package:saloon_app/view/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/view/popup_widgets/share_popup.dart';
import 'package:saloon_app/view/saloon_details/saloon_specialist.dart';

class SaloonDetailsScreen extends StatefulWidget {
  final bool isOpen;
  const SaloonDetailsScreen({Key key, this.isOpen}) : super(key: key);

  @override
  _SaloonDetailsScreenState createState() => _SaloonDetailsScreenState();
}

class _SaloonDetailsScreenState extends State<SaloonDetailsScreen> {
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

  List<SaloonDetailsTabModel> saloonDetailsTabList = [
    SaloonDetailsTabModel(
      title: "About",
      isSelected: true,
      index: 1,
    ),
    SaloonDetailsTabModel(
      title: "Services",
      isSelected: false,
      index: 2,
    ),
    SaloonDetailsTabModel(
      title: "Package",
      isSelected: false,
      index: 3,
    ),
    SaloonDetailsTabModel(
      title: "Gallery",
      isSelected: false,
      index: 4,
    ),
    SaloonDetailsTabModel(
      title: "Review",
      isSelected: false,
      index: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorUtilities.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 340,
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
                                    imageUrl:
                                        AssetUtilities.saloonScreenMainImagePng,
                                    isFromAssets: true,
                                    fit: BoxFit.cover,
                                    height: 10,
                                    width: 10,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, 0.8),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    3,
                                    (index) => Container(
                                      height: 6,
                                      width: 6,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: selectedPage == index
                                            ? ColorUtilities.white
                                            : ColorUtilities.white
                                                .withOpacity(0.3),
                                      ),
                                    ),
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
                            BackArrow(
                              color: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.dark_900,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Bella Rinova',
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
                  delegate: SliverChildListDelegate.fixed([
                    Container(
                      color: _themeController.isDarkMode
                          ? ColorUtilities.dark_900
                          : ColorUtilities.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25, right: 25, top: 0, bottom: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Bella Rinova',
                                  style: FontStyleUtilities.h3(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                    fontWeight: FWT.semiBold,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: widget.isOpen
                                          ? ColorUtilities.green_600
                                          : ColorUtilities.red_500,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Text(
                                    widget.isOpen ? 'Open' : 'Close',
                                    style: FontStyleUtilities.t3(
                                      fontColor: ColorUtilities.white,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: Text(
                              '6391 Elgin st, Celina, Delaware 10299',
                              style: FontStyleUtilities.t2(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.text_400
                                    : ColorUtilities.text_500,
                                fontWeight: FWT.regular,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
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
                                  '(76 Reviews)',
                                  style: FontStyleUtilities.t2(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.text_500
                                        : ColorUtilities.text_300,
                                    fontWeight: FWT.regular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                {
                                  "icon": AssetUtilities.chromeStrokeSvg,
                                  "title": "Website",
                                  "onTap": () {},
                                },
                                {
                                  "icon": AssetUtilities.phoneStrokeSvg,
                                  "title": "Call",
                                  "onTap": () {},
                                },
                                {
                                  "icon": AssetUtilities.mapPinStrokeSvg,
                                  "title": "Direction",
                                  "onTap": () {},
                                },
                                {
                                  "icon": AssetUtilities.shareStrokeSvg,
                                  "title": "Share",
                                  "onTap": () {
                                    Get.bottomSheet(SharePopup());
                                  },
                                },
                              ]
                                  .map((e) => GestureDetector(
                                        onTap: e['onTap'] ?? () {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomSvgView(
                                                imageUrl: e['icon'],
                                                isFromAssets: true,
                                                height: 20,
                                                width: 20,
                                                svgColor: _themeController
                                                        .isDarkMode
                                                    ? ColorUtilities.dark_100
                                                    : ColorUtilities.text_900,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                e['title'],
                                                style: FontStyleUtilities.t3(
                                                  fontColor: _themeController
                                                          .isDarkMode
                                                      ? ColorUtilities.text_400
                                                      : ColorUtilities.text_900,
                                                  fontWeight: FWT.regular,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'Salon specialists',
                              style: FontStyleUtilities.t1(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: detailsScreenList
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
                                SizedBox(width: 5),
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
                                    saloonDetailsTabList.length,
                                    (index) {
                                      SaloonDetailsTabModel service =
                                          saloonDetailsTabList[index];
                                      return CommonChip(
                                        title: service.title,
                                        radius: 30,
                                        isSelected: service.isSelected,
                                        chipType: ChipType.simple,
                                        activeColor: _themeController.isDarkMode
                                            ? ColorUtilities.white
                                            : ColorUtilities.text_900,
                                        inactiveColor:
                                            ColorUtilities.transparant,
                                        onChipTap: (bool isSelected) {
                                          setState(() {
                                            saloonDetailsTabList
                                                .forEach((element) {
                                              element.isSelected = false;
                                            });
                                            saloonDetailsTabList[index]
                                                .isSelected = isSelected;
                                          });
                                          _tabPageController.jumpToPage(index);
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
                              AboutTab(_themeController),
                              ServiceTab(_themeController),
                              PackageTab(),
                              GalleryTab(),
                              ReviewTab(_themeController),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

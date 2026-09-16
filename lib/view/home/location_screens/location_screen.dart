import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/filter_screen/filter_screen.dart';
import 'package:saloon_app/view/saloon_details/saloon_details_screen.dart';

/// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  PageController _pageController;

  BitmapDescriptor _selectedMarkerImage;
  BitmapDescriptor _deselectedMarkerImage;
  BitmapDescriptor _userMarkerImage;
  String _mapStyle;
  GoogleMapController _mapStyleController;

  getMarker() async {
    _selectedMarkerImage =
        await _bitmapDescriptorFromSvgAsset(context, AssetUtilities.mapPinSvg);
    _deselectedMarkerImage =
        await _bitmapDescriptorFromSvgAsset(context, AssetUtilities.mapPinWSvg);
    _userMarkerImage =
        await _bitmapDescriptorFromSvgAsset(context, AssetUtilities.mapUserSvg);

    setState(() {});
  }

  @override
  void initState() {
    rootBundle.loadString(AssetUtilities.mapStyleJson).then((string) {
      _mapStyle = string;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMarker();
    });
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  List<Map> locationSaloonList = [
    {
      "lat": 42.93168011802103,
      "long": -76.56932484358549,
      "isSelected": true,
    },
    {
      "lat": 42.941920605146386,
      "long": -76.57662481069565,
      "isSelected": false,
    },
    {
      "lat": 42.93723036905049,
      "long": -76.56054429709911,
      "isSelected": false,
    },
    {
      "lat": 42.93424948176265,
      "long": -76.58167205750942,
      "isSelected": false,
    },
    {
      "lat": 42.92564818482027,
      "long": -76.56665202230215,
      "isSelected": false,
    },
  ];

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        32 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  Completer<GoogleMapController> _completerController = Completer();

  Future<void> _goToSaloon(LatLng position) async {
    final GoogleMapController controller = await _completerController.future;
    final CameraPosition _saloonPosition =
        CameraPosition(target: position, zoom: 13.6);
    controller.animateCamera(CameraUpdate.newCameraPosition(_saloonPosition));
  }

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
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenSize.height - 200,
                  width: screenSize.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(42.918519377608916, -76.57377999275923),
                      zoom: 13.6,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _mapStyleController = controller;
                      _mapStyleController.setMapStyle(_mapStyle);
                      _completerController.complete(controller);
                    },
                    buildingsEnabled: true,
                    mapToolbarEnabled: false,
                    markers: List.generate(
                      locationSaloonList.length + 1,
                      (index) => Marker(
                        markerId: MarkerId(index.toString()),
                        position: index < locationSaloonList.length
                            ? LatLng(locationSaloonList[index]['lat'],
                                locationSaloonList[index]['long'])
                            : LatLng(42.918519377608916, -76.57377999275923),
                        icon: index < locationSaloonList.length
                            ? ((locationSaloonList[index]['isSelected']
                                    ? _selectedMarkerImage
                                    : _deselectedMarkerImage) ??
                                BitmapDescriptor.defaultMarker)
                            : (_userMarkerImage ??
                                BitmapDescriptor.defaultMarker),
                        anchor: index < locationSaloonList.length
                            ? Offset(0.5, 1.0)
                            : Offset(0.3, 0.5),
                        onTap: index < locationSaloonList.length
                            ? () {
                                _pageController.jumpToPage(
                                  index,
                                  // duration: Duration(milliseconds: 500),
                                  // curve: Curves.decelerate
                                );

                                setState(() {
                                  locationSaloonList.forEach((element) {
                                    element['isSelected'] = false;
                                  });
                                });
                                locationSaloonList[index]['isSelected'] = true;
                                _goToSaloon(LatLng(
                                    locationSaloonList[index]['lat'],
                                    locationSaloonList[index]['long']));
                              }
                            : () {},
                      ),
                    ).toSet(),
                    circles: {
                      Circle(
                        circleId: CircleId("1"),
                        center: LatLng(42.918519377608916, -76.57377999275923),
                        radius: 700,
                        fillColor: ColorUtilities.primary_400.withOpacity(0.2),
                        strokeColor: ColorUtilities.transparant,
                        strokeWidth: 0,
                      )
                    },
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 180,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    color: _themeController.isDarkMode
                        ? ColorUtilities.dark_900
                        : ColorUtilities.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomSvgView(
                            imageUrl: AssetUtilities.mapPinStrokeSvg,
                            isFromAssets: true,
                            height: 13,
                            width: 13,
                            svgColor: _themeController.isDarkMode
                                ? ColorUtilities.text_400
                                : ColorUtilities.text_900,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '6391 Elgin St. Celina, Delaware 10299',
                            style: FontStyleUtilities.t2(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.text_400
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      CustomSearchbar(
                        hintText: "Search by Salons",
                        onSearchActionTap: () {
                          Get.to(
                            FilterScreen(),
                            transition: Transition.downToUp,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.95),
                child: Container(
                  height: 110,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int selectedPageIndex) {
                      setState(() {
                        locationSaloonList.forEach((element) {
                          element['isSelected'] = false;
                        });
                      });
                      locationSaloonList[selectedPageIndex]['isSelected'] =
                          true;
                      _goToSaloon(LatLng(
                          locationSaloonList[selectedPageIndex]['lat'],
                          locationSaloonList[selectedPageIndex]['long']));
                    },
                    children: [
                      {
                        "title": "Bella Rinova",
                        "address": "6391 Elgin St. Celina, Delaware, New York",
                        "rate": 5,
                        "distance": "25 km",
                        "open": true,
                        "image": AssetUtilities.homeScreenMakeUpPng,
                      },
                      {
                        "title": "The Galleria",
                        "address": "4140 Parker Rd, Allentown",
                        "rate": 3,
                        "distance": "5 km",
                        "open": true,
                        "image": AssetUtilities.homeScreenHairCutsPng,
                      },
                      {
                        "title": "Green Apple",
                        "address": "8502 Preston Rd, Inglewood",
                        "rate": 4,
                        "distance": "15 km",
                        "open": false,
                        "image": AssetUtilities.homeScreenManicurePng,
                      },
                      {
                        "title": "Rini Rinova",
                        "address": "6391 Elgin St. Celina, Delaware, New York",
                        "rate": 5,
                        "distance": "50 km",
                        "open": true,
                        "image": AssetUtilities.homeScreenVoucherPng,
                      },
                      {
                        "title": "The Plantia",
                        "address": "4140 Parker Rd, Allentown",
                        "rate": 5,
                        "distance": "5 km",
                        "open": true,
                        "image": AssetUtilities.homeScreenProfilePng,
                      },
                    ]
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: SalonCard(
                              width: screenSize.width - 60,
                              image: e['image'] ??
                                  AssetUtilities.homeScreenNearestListPng,
                              title: e['title'] ?? '',
                              description: e['address'] ?? '',
                              cardType: SalonCardTypes.showStars,
                              rateStarsCount: e['rate'] ?? 0,
                              distance: e['distance'] ?? "0 km",
                              onCardPress: () {
                                Get.to(SaloonDetailsScreen(
                                  isOpen: e['open'],
                                ));
                              },
                            ),
                          ),
                        )
                        .toList(),
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

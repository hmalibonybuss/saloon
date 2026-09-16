import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/popup_widgets/payment_method_popup.dart';
import 'package:saloon_app/view/saloon_details/tabs/service_tab_tile.dart';
import 'package:saloon_app/view/saloon_details/tabs/service_type_screen.dart';

class ServiceTab extends StatefulWidget {
  final ThemeController themeController;

  ServiceTab(this.themeController, {Key key}) : super(key: key);

  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  List<Map> serviceTabTileList = [
    {
      "title": "Hair Wash",
      "serviceTypes": "12 types",
      "tileType": ServiceTabTileType.inactive,
      "selectedServiceType": null,
      "selectedServiceAmt": null,
    },
    {
      "title": "Hair Cut",
      "serviceTypes": "12 types",
      "tileType": ServiceTabTileType.active,
      "selectedServiceType": "Regular haircut",
      "selectedServiceAmt": "5.00",
    },
    {
      "title": "Hair Coloring",
      "serviceTypes": "7 types",
      "tileType": ServiceTabTileType.inactive,
      "selectedServiceType": null,
      "selectedServiceAmt": null,
    },
    {
      "title": "Eye Mackup",
      "serviceTypes": "2 types",
      "tileType": ServiceTabTileType.inactive,
      "selectedServiceType": null,
      "selectedServiceAmt": null,
    },
    {
      "title": "Shaving",
      "serviceTypes": "6 types",
      "tileType": ServiceTabTileType.active,
      "selectedServiceType": "Classic shaving",
      "selectedServiceAmt": "3.12",
    },
    {
      "title": "Hair Dryer",
      "serviceTypes": "3 types",
      "tileType": ServiceTabTileType.inactive,
      "selectedServiceType": null,
      "selectedServiceAmt": null,
    },
  ];

  double totalAmt = 8.12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Column(
            children: List.generate(
              serviceTabTileList.length,
              (index) {
                Map service = serviceTabTileList[index];
                return ServiceTabTile(
                  themeController: widget.themeController,
                  service: service,
                  onPress: () {
                    Get.to(
                      ServiceTypeScreen(
                        onSelect: (String serviceType, String serviceAmt) {
                          setState(() {
                            serviceTabTileList[index]['selectedServiceType'] =
                                serviceType;

                            serviceTabTileList[index]['selectedServiceAmt'] =
                                serviceAmt;
                            serviceTabTileList[index]['tileType'] =
                                ServiceTabTileType.active;
                                                      totalAmt = 0.0;
                            serviceTabTileList.forEach((element) {
                              if (element['selectedServiceAmt'] != null) {
                                totalAmt = totalAmt +
                                    double.parse(element['selectedServiceAmt']
                                        .toString());
                              }
                            });
                          });
                        },
                      ),
                      transition: Transition.downToUp,
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 15),
          CustomButton(
            title: "BOOK NOW",
            secondTitle: "\$ ${totalAmt.toStringAsFixed(2)}",
            onButtonTap: () {
              Get.bottomSheet(
                PaymentMethodPopup(),
              );
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

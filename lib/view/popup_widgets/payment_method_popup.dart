import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/popup_widgets/payment_method_tile.dart';

/// ignore: must_be_immutable
class PaymentMethodPopup extends StatefulWidget {
  @override
  _PaymentMethodPopupState createState() => _PaymentMethodPopupState();
}

class _PaymentMethodPopupState extends State<PaymentMethodPopup> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  List<Map> paymentMethodList = [
    {
      "name": "Jenny Wilson",
      "cardNumber": "**** **** **** 6457",
      "imageLight": AssetUtilities.paypalLightPaymentPng,
      "imageDark": AssetUtilities.paypalDarkPaymentPng,
      "isSelected": true,
    },
    {
      "name": "**** **** **** 8295",
      "imageLight": AssetUtilities.masterCardPaymentPng,
      "imageDark": AssetUtilities.masterCardPaymentPng,
      "isSelected": false,
    },
    {
      "name": "**** **** **** 5445",
      "imageLight": AssetUtilities.visaCardLightPaymentPng,
      "imageDark": AssetUtilities.visaCardDarkPaymentPng,
      "isSelected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    alignment: Alignment.center,
                    height: screenSize.height / 2,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: _themeController.isDarkMode
                          ? ColorUtilities.dark_900
                          : ColorUtilities.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Payment Method',
                              style: FontStyleUtilities.h4(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.text_900,
                                fontWeight: FWT.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              children: List.generate(
                                paymentMethodList.length,
                                (index) {
                                  Map paymentMethod = paymentMethodList[index];
                                  return PaymentMethodTile(
                                    themeController: _themeController,
                                    name: paymentMethod['name'],
                                    isSelected: paymentMethod['isSelected'],
                                    image: paymentMethod[
                                        _themeController.isDarkMode
                                            ? 'imageDark'
                                            : 'imageLight'],
                                    onTap: () {
                                      setState(() {
                                        paymentMethodList.forEach((element) {
                                          element['isSelected'] = false;
                                        });
                                        paymentMethodList[index]['isSelected'] =
                                            true;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomButton(
                              title: "Continue",
                              width: screenSize.width,
                              onButtonTap: () {
                                Get.back();
                              },
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

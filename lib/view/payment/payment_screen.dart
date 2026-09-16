import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/popup_widgets/popup_widgets.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Map> paymentMethodList = [];

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

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
            body: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        'Payment Methods',
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
                paymentMethodList.length >= 1
                    ? _getCardList(screenSize)
                    : _getAddNewArea(screenSize),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getCardList(Size screenSize) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: paymentMethodList
                  .map(
                    (e) => PaymentMethodTile(
                      name: e['name'],
                      isSelected: false, // this will be false for this page...
                      themeController: _themeController,
                      activeTextColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      inactiveTextColor: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                      image: e[_themeController.isDarkMode
                          ? 'imageDark'
                          : 'imageLight'],
                      onTap: () {},
                      paymentTileType: PaymentTileType.addNew,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(PaymentMethodAddCardPopup());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                color: ColorUtilities.transparant,
                child: Row(
                  children: [
                    CustomSvgView(
                      imageUrl: AssetUtilities.plusStrokeSvg,
                      isFromAssets: true,
                      height: 16,
                      width: 16,
                      svgColor: _themeController.isDarkMode
                          ? ColorUtilities.primary_400
                          : ColorUtilities.primary_700,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Add Payment Method',
                      style: FontStyleUtilities.t2(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.primary_400
                            : ColorUtilities.primary_700,
                        fontWeight: FWT.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAddNewArea(Size screenSize) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvgView(
            imageUrl: AssetUtilities.creditCardStrokeSvg,
            isFromAssets: true,
            height: 60,
            width: 60,
            svgColor: _themeController.isDarkMode
                ? ColorUtilities.white
                : ColorUtilities.text_900,
          ),
          SizedBox(height: 40),
          Container(
            width: screenSize.width / 2,
            child: Text(
              'you don\'t have any payment method. Add now',
              textAlign: TextAlign.center,
              style: FontStyleUtilities.p1(
                fontColor: _themeController.isDarkMode
                    ? ColorUtilities.white
                    : ColorUtilities.text_900,
                fontWeight: FWT.regular,
              ),
            ),
          ),
          SizedBox(height: 50),
          CustomButton(
            title: "Add New",
            width: screenSize.width / 2,
            onButtonTap: () {
              setState(() {
                paymentMethodList.addAll([
                  {
                    "name": "Jenny Wilson",
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
                ]);
              });
              Get.bottomSheet(PaymentMethodAddCardPopup());
            },
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

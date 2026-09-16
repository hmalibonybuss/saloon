import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/booking_success_screen.dart';
import 'package:saloon_app/view/popup_widgets/popup_widgets.dart';
import 'package:saloon_app/view/saloon_details/saloon_details_screen.dart';

class BookingFinalizeScreen extends StatefulWidget {
  @override
  _BookingFinalizeScreenState createState() => _BookingFinalizeScreenState();
}

class _BookingFinalizeScreenState extends State<BookingFinalizeScreen> {
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
    return SafeArea(
      child: GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Scaffold(
            backgroundColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Book Appointment',
                      style: FontStyleUtilities.h3(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SalonCard(
                      image: AssetUtilities.homeScreenNearestListPng,
                      title: 'Bella Rinova',
                      description: '6391 Elgin St. Celina, Delaware, New York',
                      cardType: SalonCardTypes.showStars,
                      rateStarsCount: 4,
                      distance: "22 KM",
                      onCardPress: () {
                        Get.to(SaloonDetailsScreen(
                          isOpen: true,
                        ));
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Services',
                      style: FontStyleUtilities.h5(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _serviceFinalTile(
                      image: AssetUtilities.searchScreenLilyPng,
                      title: "Regular Haircut",
                      price: "5.00",
                    ),
                    SizedBox(height: 10),
                    _serviceFinalTile(
                      image: AssetUtilities.searchScreenMikePng,
                      title: "Classic Shaving",
                      price: "3.12",
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'Date & Time',
                          style: FontStyleUtilities.h5(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '12 September, 12:00',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyleUtilities.t1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.primary_400
                                : ColorUtilities.primary_700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Payment Method',
                      style: FontStyleUtilities.h5(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: List.generate(
                        paymentMethodList.length,
                        (index) {
                          Map paymentMethod = paymentMethodList[index];
                          return PaymentMethodTile(
                            themeController: _themeController,
                            name: paymentMethod['name'],
                            isSelected: paymentMethod['isSelected'],
                            image: paymentMethod[_themeController.isDarkMode
                                ? 'imageDark'
                                : 'imageLight'],
                            onTap: () {
                              setState(() {
                                paymentMethodList.forEach((element) {
                                  element['isSelected'] = false;
                                });
                                paymentMethodList[index]['isSelected'] = true;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            color: ColorUtilities.transparant,
                            child: Text(
                              'Back',
                              style: FontStyleUtilities.h5(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.text_300
                                    : ColorUtilities.text_500,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        CustomButton(
                          title: "Continue",
                          secondTitle: "\$ 8.12",
                          onButtonTap: () {
                            Get.to(BookingSuccessScreen());
                          },
                          width: 200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _serviceFinalTile({
    String image,
    String title,
    String price,
  }) {
    return Row(
      children: [
        CustomImageView(
          imageUrl: image ?? AssetUtilities.searchScreenLilyPng,
          isFromAssets: true,
          height: 25,
          width: 25,
          fit: BoxFit.cover,
          radius: BorderRadius.circular(5),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FontStyleUtilities.t1(
              fontColor: _themeController.isDarkMode
                  ? ColorUtilities.text_400
                  : ColorUtilities.text_900,
            ),
          ),
        ),
        Text(
          price != null ? '\$ $price' : '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: FontStyleUtilities.t1(
            fontColor: _themeController.isDarkMode
                ? ColorUtilities.primary_400
                : ColorUtilities.primary_700,
          ),
        ),
      ],
    );
  }
}

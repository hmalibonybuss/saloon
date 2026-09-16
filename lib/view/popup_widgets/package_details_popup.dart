import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/saloon_details/tabs/tabs.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/book_appointment_screen.dart';

/// ignore: must_be_immutable
class PackageDetailsPopup extends StatefulWidget {
  final PackageModel package;

  const PackageDetailsPopup({Key key, this.package}) : super(key: key);
  @override
  _PackageDetailsPopupState createState() => _PackageDetailsPopupState();
}

class _PackageDetailsPopupState extends State<PackageDetailsPopup> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

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
                    height: screenSize.height - 200,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                CustomImageView(
                                  imageUrl: widget.package.image,
                                  isFromAssets: true,
                                  height: 135,
                                  width: screenSize.width,
                                  fit: BoxFit.cover,
                                  radius: BorderRadius.circular(20),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  widget.package.title ?? '',
                                  style: FontStyleUtilities.h5(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                    fontWeight: FWT.semiBold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.package.subTitle ?? '',
                                  style: FontStyleUtilities.t3(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.text_500
                                        : ColorUtilities.text_300,
                                    fontWeight: FWT.regular,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  widget.package.description ?? '',
                                  style: FontStyleUtilities.p1(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.text_400
                                        : ColorUtilities.text_600,
                                    fontWeight: FWT.regular,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Service',
                                  style: FontStyleUtilities.h5(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                    fontWeight: FWT.semiBold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Wrap(
                                  children: List.generate(
                                    widget.package.services.length,
                                    (index) {
                                      String service =
                                          widget.package.services[index];
                                      return Container(
                                        width: ((screenSize.width - 60) / 2),
                                        height: 30,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomSvgView(
                                              imageUrl: AssetUtilities
                                                  .checkTrueStrokeSvg,
                                              isFromAssets: true,
                                              width: 15,
                                              height: 11,
                                              svgColor:
                                                  ColorUtilities.green_500,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              service ?? '',
                                              style: FontStyleUtilities.t1(
                                                fontColor: _themeController
                                                        .isDarkMode
                                                    ? ColorUtilities.text_400
                                                    : ColorUtilities.text_900,
                                                fontWeight: FWT.regular,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 30),
                                CustomButton(
                                  title: "\$ ${widget.package.amt}",
                                  secondTitle: "BOOK NOW",
                                  onButtonTap: () {
                                    Get.to(BookAppointmentScreen());
                                  },
                                ),
                                SizedBox(height: 30),
                              ]),
                        ),
                      ),
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

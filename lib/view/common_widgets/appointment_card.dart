import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

enum AppointmentCardType {
  upComing,
  upComingMap,
  pass,
  passMap,
}

/// ignore: must_be_immutable
class AppointmentListCard extends StatelessWidget {
  final String image;
  final String title;
  final String address;
  final String date;
  final String service;
  final AppointmentCardType appointmentCardType;
  final OnChange onRadioChange;
  final OnChangeDropdownValue onChangeDropdownValue;
  final dynamic dropdownSelectedValue;
  final List<DropdownMenuItem> dropdownItems;
  final VoidCallback onCancle;
  final VoidCallback onReview;
  final VoidCallback onReschedule;

  AppointmentListCard({
    Key key,
    this.image,
    this.title,
    this.address,
    this.service,
    this.appointmentCardType,
    this.date,
    this.onRadioChange,
    this.dropdownSelectedValue,
    this.onChangeDropdownValue,
    this.dropdownItems,
    this.onCancle,
    this.onReview,
    this.onReschedule,
  }) : super(key: key);
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: _themeController.isDarkMode
                ? ColorUtilities.dark_800
                : ColorUtilities.transparant,
            border: Border.all(
              color: _themeController.isDarkMode
                  ? ColorUtilities.transparant
                  : ColorUtilities.light_500,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height:
                      appointmentCardType == AppointmentCardType.upComingMap ||
                              appointmentCardType == AppointmentCardType.passMap
                          ? 0
                          : 20),
              appointmentCardType == AppointmentCardType.upComingMap ||
                      appointmentCardType == AppointmentCardType.passMap
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        date ?? '',
                        style: FontStyleUtilities.h5(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
              SizedBox(
                  height:
                      appointmentCardType == AppointmentCardType.upComingMap ||
                              appointmentCardType == AppointmentCardType.passMap
                          ? 0
                          : 10),
              appointmentCardType == AppointmentCardType.upComingMap ||
                      appointmentCardType == AppointmentCardType.passMap
                  ? CustomImageView(
                      imageUrl: AssetUtilities.saloonScreenMapPng,
                      height: 127,
                      width: screenSize.width,
                      isFromAssets: true,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(30),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imageUrl: image ?? '',
                            isFromAssets: true,
                            height: 90,
                            width: 100,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(20),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title ?? '',
                                  style: FontStyleUtilities.t2(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                    fontWeight: FWT.regular,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  address ?? '',
                                  style: FontStyleUtilities.t3(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.text_400
                                        : ColorUtilities.text_300,
                                    fontWeight: FWT.regular,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                service != ""
                                    ? Text(
                                        "Services : " + service ?? '',
                                        style: FontStyleUtilities.t3(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.primary_400
                                              : ColorUtilities.primary_700,
                                          fontWeight: FWT.regular,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                  height:
                      appointmentCardType == AppointmentCardType.upComingMap ||
                              appointmentCardType == AppointmentCardType.passMap
                          ? 10
                          : 0),
              appointmentCardType == AppointmentCardType.upComingMap ||
                      appointmentCardType == AppointmentCardType.passMap
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        date ?? '',
                        style: FontStyleUtilities.h5(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    )
                  : SizedBox(),
              appointmentCardType == AppointmentCardType.upComingMap ||
                      appointmentCardType == AppointmentCardType.passMap
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        address ?? '',
                        style: FontStyleUtilities.t3(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.text_400
                              : ColorUtilities.text_300,
                          fontWeight: FWT.regular,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                  height:
                      appointmentCardType == AppointmentCardType.upComingMap ||
                              appointmentCardType == AppointmentCardType.passMap
                          ? 10
                          : 0),
              appointmentCardType == AppointmentCardType.upComingMap ||
                      appointmentCardType == AppointmentCardType.passMap
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: service != ""
                          ? Text(
                              "Services : " + service ?? '',
                              style: FontStyleUtilities.t3(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.primary_400
                                    : ColorUtilities.primary_700,
                                fontWeight: FWT.regular,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox(),
                    )
                  : SizedBox(),
              SizedBox(height: 10),
              appointmentCardType == AppointmentCardType.upComing ||
                      appointmentCardType == AppointmentCardType.upComingMap
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomSwitchButton(
                            onChange: onRadioChange ?? (value) {},
                          ),
                          SizedBox(width: 10),
                          CustomDropDown(
                            onChange: onChangeDropdownValue ?? (value) {},
                            selectedValue: dropdownSelectedValue,
                            isExpanded: false,
                            isFlat: true,
                            hint: "Remind me ",
                            items: dropdownItems ?? [],
                          ),
                          Spacer(),
                          CustomButton(
                            title: "Cancel",
                            isFlatButton: true,
                            buttonSize: ButtonSize.small,
                            onButtonTap: onCancle ?? () {},
                          ),
                        ],
                      ),
                    )
                  : appointmentCardType == AppointmentCardType.pass ||
                          appointmentCardType == AppointmentCardType.passMap
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomButton(
                                title: "Review",
                                isFlatButton: true,
                                buttonSize: ButtonSize.small,
                                onButtonTap: onReview ?? () {},
                              ),
                              SizedBox(width: 10),
                              CustomButton(
                                title: "Reschedule",
                                buttonSize: ButtonSize.small,
                                onButtonTap: onReschedule ?? () {},
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

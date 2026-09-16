import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/popup_widgets/cancle_popup.dart';

class UpcommingScreen extends StatefulWidget {
  final bool isMapSelected;

  const UpcommingScreen({Key key, this.isMapSelected}) : super(key: key);

  @override
  _UpcommingScreenState createState() => _UpcommingScreenState();
}

class _UpcommingScreenState extends State<UpcommingScreen> {
  dynamic dropdownSelectedValue;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [1, 2, 3].map((e) {
                return AppointmentListCard(
                  title: "Bella Renova",
                  address: "6391 Elgin St. Celina, Dela...",
                  date: "12 September 2021, 08:00",
                  service: "Regular Haircut, Classic Sheving",
                  appointmentCardType: widget.isMapSelected
                      ? AppointmentCardType.upComingMap
                      : AppointmentCardType.upComing,
                  image: AssetUtilities.appointMentListImage1Png,
                  onRadioChange: (bool value) {},
                  dropdownItems: [
                    DropdownMenuItem(
                      child: Text(
                        '30 min before',
                        style: FontStyleUtilities.p2(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        '15 min before',
                        style: FontStyleUtilities.p2(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900),
                      ),
                      value: 2,
                    ),
                  ],
                  dropdownSelectedValue: dropdownSelectedValue,
                  onChangeDropdownValue: (dynamic value) {
                    setState(() {
                      dropdownSelectedValue = value;
                    });
                  },
                  onCancle: () {
                    Get.dialog(CanclePopup());
                  },
                );
              }).toList(),
            ),
          );
        });
  }
}

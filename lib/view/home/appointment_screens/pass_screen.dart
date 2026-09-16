import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/appointment_screens/book_appointment_screen.dart';

class PassScreen extends StatefulWidget {
  final bool isMapSelected;

  const PassScreen({Key key, this.isMapSelected}) : super(key: key);

  @override
  _PassScreenState createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  dynamic dropdownSelectedValue;
  @override
  Widget build(BuildContext context) {
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
                ? AppointmentCardType.passMap
                : AppointmentCardType.pass,
            image: AssetUtilities.appointMentListImage1Png,
            onRadioChange: (bool value) {},
            onReschedule: () {
              Get.to(BookAppointmentScreen());
            },
            dropdownItems: [
              DropdownMenuItem(
                child: Text('30 min before'),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text('15 min before'),
                value: 2,
              ),
            ],
            dropdownSelectedValue: dropdownSelectedValue,
            onChangeDropdownValue: (dynamic value) {
              setState(() {
                dropdownSelectedValue = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

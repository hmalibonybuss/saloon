import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/utilities/font_style_utils.dart';
import 'package:saloon_app/view/auth/auth_common_widgets/auth_common_widgets.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  final List<Map> genderList = [
    {
      "title": "male",
      "value": "1",
    },
    {
      "title": "female",
      "value": "2",
    },
  ];

  String selectedValue;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: _themeController.isDarkMode
                  ? ColorUtilities.dark_900
                  : ColorUtilities.white,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CustomSvgView(
                              imageUrl: AssetUtilities.closeStrokeSvg,
                              isFromAssets: true,
                              height: 15,
                              width: 15,
                              svgColor: _themeController.isDarkMode
                                  ? ColorUtilities.dark_100
                                  : ColorUtilities.text_900,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomImageView(
                            imageUrl: AssetUtilities.homeScreenProfilePng,
                            isFromAssets: true,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(20),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Change Avatar',
                            style: FontStyleUtilities.t2(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.primary_400
                                  : ColorUtilities.primary_700,
                              fontWeight: FWT.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Full name',
                        style: FontStyleUtilities.t2(
                          fontColor: ColorUtilities.text_400,
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        hint: "Robert Fox",
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email',
                        style: FontStyleUtilities.t2(
                          fontColor: ColorUtilities.text_400,
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                          hint: "robart_fox@gmail.com",
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: FontStyleUtilities.t2(
                                  fontColor: ColorUtilities.text_400,
                                ),
                              ),
                              SizedBox(height: 5),
                              CustomDropDown(
                                items: genderList
                                    .map((e) => DropdownMenuItem(
                                          child: Text(
                                            e['title'],
                                          ),
                                          value: e['value'],
                                        ))
                                    .toList(),
                                width: (screenSize.width - 60) / 2,
                                hint: "Gender",
                                selectedValue: selectedValue,
                                onChange: (dynamic value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Birth of date',
                                style: FontStyleUtilities.t2(
                                  fontColor: ColorUtilities.text_400,
                                ),
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                hint: "DD.MM.YYYY",
                                keyboardType: TextInputType.datetime,
                                width: (screenSize.width - 60) / 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Address',
                        style: FontStyleUtilities.t2(
                          fontColor: ColorUtilities.text_400,
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                          hint: "6391 Elgin St. Celina, Delaware 10299",
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 20),
                      Text(
                        'Phone Number',
                        style: FontStyleUtilities.t2(
                          fontColor: ColorUtilities.text_400,
                        ),
                      ),
                      SizedBox(height: 5),
                      VerifyPhoneField(
                        hint: "Enter Number",
                        validator: (String value) {
                          if (value.length < 10 || value.length > 12) {
                            return "Please Enter Correct Number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      CustomButton(
                        title: "Save",
                        onButtonTap: () {
                          Get.back();
                        },
                        width: screenSize.width,
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

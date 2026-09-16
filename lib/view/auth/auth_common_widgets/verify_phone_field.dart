import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/model/auth/country_data_model.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// THIS IS THE FUNCTION SIGNATURE FOR CHANGE SELECTED COUNTRY CODE...
typedef OnCountryChange = void Function(String);

/// THIS IS THE FUNCTION SIGNATURE FOR VALIDATOR...
typedef Validator = String Function(String);

enum ValidationType {
  error,
  success,
  typing,
}

/// ignore: must_be_immutable
class VerifyPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final OnCountryChange onCountryChange;
  final Validator validator;
  final TextInputType keyboardType;

  VerifyPhoneField({
    Key key,
    this.controller,
    this.hint,
    this.onCountryChange,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  ValidationType validationType = ValidationType.typing;
  @override
  _VerifyPhoneFieldState createState() => _VerifyPhoneFieldState();
}

class _VerifyPhoneFieldState extends State<VerifyPhoneField> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  final List<CountryDataModel> coutryDataList = [
    CountryDataModel(
      countryName: "Vietnam",
      countryCode: "+84",
      countryFlag: AssetUtilities.vietnamFlagPng,
    ),
    CountryDataModel(
      countryName: "India",
      countryCode: "+91",
      countryFlag: AssetUtilities.indiaFlagPng,
    ),
    CountryDataModel(
      countryName: "USA",
      countryCode: "+1",
      countryFlag: AssetUtilities.usaFlagPng,
    ),
    CountryDataModel(
      countryName: "Australia",
      countryCode: "+61",
      countryFlag: AssetUtilities.australiaFlagPng,
    ),
    CountryDataModel(
      countryName: "Japan",
      countryCode: "+81",
      countryFlag: AssetUtilities.japanFlagPng,
    ),
    CountryDataModel(
      countryName: "China",
      countryCode: "+86",
      countryFlag: AssetUtilities.chinaFlagPng,
    ),
    CountryDataModel(
      countryName: "Germany",
      countryCode: "+49",
      countryFlag: AssetUtilities.germanyFlagPng,
    ),
    CountryDataModel(
      countryName: "Denmark",
      countryCode: "+45",
      countryFlag: AssetUtilities.denmarkFlagPng,
    ),
  ];
  CountryDataModel selectedCountryCode;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Container(
          height: 58,
          width: screenSize.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: _themeController.isDarkMode
                ? ColorUtilities.dark_800
                : ColorUtilities.light_300,
            border: Border.all(
                color: widget.validationType == ValidationType.error
                    ? ColorUtilities.red_500
                    : ColorUtilities.transparant),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<CountryDataModel>(
                    value: selectedCountryCode,
                    dropdownColor: _themeController.isDarkMode
                        ? ColorUtilities.dark_900
                        : ColorUtilities.white,
                    onChanged: (CountryDataModel value) {
                      setState(() {
                        selectedCountryCode = value;
                      });
                    },
                    hint: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImageView(
                          imageUrl: coutryDataList[0].countryFlag,
                          isFromAssets: true,
                          height: 15,
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Text(
                          coutryDataList[0].countryCode,
                          style: FontStyleUtilities.t2(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.regular,
                          ),
                        ),
                      ],
                    ),
                    underline: SizedBox(),
                    items: coutryDataList
                        .map(
                          (CountryDataModel country) => DropdownMenuItem(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomImageView(
                                  imageUrl: country.countryFlag,
                                  isFromAssets: true,
                                  height: 15,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  country.countryCode,
                                  style: FontStyleUtilities.t2(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                    fontWeight: FWT.regular,
                                  ),
                                ),
                              ],
                            ),
                            value: country,
                          ),
                        )
                        .toList(),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.text_900,
                    ),
                  ),
                  SizedBox(height: 3),
                ],
              ),
              SizedBox(width: 10),
              VerticalDivider(
                color: _themeController.isDarkMode
                    ? ColorUtilities.light_300
                    : ColorUtilities.dark_100,
                endIndent: 10,
                indent: 10,
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (String value) {
                    setState(() {
                      widget.validationType = ValidationType.error;
                    });
                    return '';
                                      return null;
                  },
                  keyboardType: widget.keyboardType ?? TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hint ?? '',
                    hintStyle: FontStyleUtilities.t2(
                      fontColor: _themeController.isDarkMode
                          ? ColorUtilities.text_500
                          : ColorUtilities.text_300,
                      fontWeight: FWT.regular,
                    ),
                    errorBorder: InputBorder.none,
                    errorStyle: TextStyle(fontSize: 0),
                  ),
                  style: FontStyleUtilities.t2(
                    fontColor: _themeController.isDarkMode
                        ? ColorUtilities.white
                        : ColorUtilities.text_900,
                    fontWeight: FWT.regular,
                  ),
                ),
              ),
              if (widget.validationType == ValidationType.error) ...{
                CustomSvgView(
                  imageUrl: AssetUtilities.closeStrokeSvg,
                  isFromAssets: true,
                  height: 15,
                  width: 15,
                  svgColor: ColorUtilities.red_500,
                ),
              },
              if (widget.validationType == ValidationType.success) ...{
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtilities.green_500,
                  ),
                  alignment: Alignment.center,
                  child: CustomSvgView(
                    imageUrl: AssetUtilities.checkTrueStrokeSvg,
                    isFromAssets: true,
                    height: 10,
                    width: 10,
                    svgColor: ColorUtilities.white,
                  ),
                ),
              },
            ],
          ),
        );
      },
    );
  }
}

import 'dart:convert';

CountryDataModel countryDataModelFromJson(String str) =>
    CountryDataModel.fromJson(json.decode(str));

String countryDataModelToJson(CountryDataModel data) =>
    json.encode(data.toJson());

class CountryDataModel {
  CountryDataModel({
    required this.countryName,
    required this.countryCode,
    required this.countryFlag,
  });

  String countryName;
  String countryCode;
  String countryFlag;

  factory CountryDataModel.fromJson(Map<String, dynamic> json) =>
      CountryDataModel(
        countryName: json["country_name"],
        countryCode: json["country_code"],
        countryFlag: json["country_flag"],
      );

  Map<String, dynamic> toJson() => {
        "country_name": countryName,
        "country_code": countryCode,
        "country_flag": countryFlag,
      };
}

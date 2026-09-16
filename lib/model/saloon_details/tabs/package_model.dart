class PackageModel {
  String title;
  String subTitle;
  String description;
  String image;
  String amt;
  List<String> services;

  PackageModel(
      {required this.title,
      required this.subTitle,
      required this.description,
      required this.image,
      required this.amt,
      required this.services});
}

import 'package:flutter/material.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/utilities/color_utils.dart';
import 'package:saloon_app/utilities/font_style_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

class ReviewTab extends StatefulWidget {
  final ThemeController themeController;

  ReviewTab(this.themeController, {Key key}) : super(key: key);

  @override
  _ReviewTabState createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  int selectedStarCount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Write your review',
                style: FontStyleUtilities.t3(
                  fontColor: widget.themeController.isDarkMode
                      ? ColorUtilities.white
                      : ColorUtilities.text_900,
                  fontWeight: FWT.regular,
                ),
              ),
              Spacer(),
              getStars(
                widget.themeController,
                isDetailed: true,
                starCount: selectedStarCount,
                onRateChange: (int rate) {
                  setState(() {
                    selectedStarCount = rate;
                  });
                },
                size: Size(15, 15),
              ),
            ],
          ),
          SizedBox(height: 15),
          CustomTextField(
            hint: "Leave your experience.",
            icon: AssetUtilities.imageStrokeSvg,
            suffixIcon: CustomSvgView(
              imageUrl: AssetUtilities.sendStrokeSvg,
              isFromAssets: true,
              height: 16,
              width: 16,
              svgColor: widget.themeController.isDarkMode
                  ? ColorUtilities.primary_400
                  : ColorUtilities.primary_700,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'All reviews(76)',
            style: FontStyleUtilities.t3(
              fontColor: widget.themeController.isDarkMode
                  ? ColorUtilities.white
                  : ColorUtilities.text_900,
              fontWeight: FWT.semiBold,
            ),
          ),
          SizedBox(height: 20),
          ReviewCard(
            themeController: widget.themeController,
            image: AssetUtilities.reviewProfile01Png,
            name: "Vicky Pirachel",
            timeAgo: "2 days ago",
            stars: 4,
            review:
                "The people working here are just so nice and helpful and make you feel so comfortable !",
          ),
          SizedBox(height: 25),
          ReviewCard(
            themeController: widget.themeController,
            image: AssetUtilities.reviewProfile02Png,
            name: "Shadia Akle",
            timeAgo: "3 months ago",
            stars: 2,
            review:
                "I asked for I simple cut and showed the photo about what I was looking for. At the end I got an uneven cut which mode me unhappy, as you can see hair looks horrible.",
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imageUrl: AssetUtilities.review01Png,
                isFromAssets: true,
                height: 70,
                width: 70,
                radius: BorderRadius.circular(15),
                fit: BoxFit.cover,
              ),
              SizedBox(width: 8),
              CustomImageView(
                imageUrl: AssetUtilities.review02Png,
                isFromAssets: true,
                height: 70,
                width: 70,
                radius: BorderRadius.circular(15),
                fit: BoxFit.cover,
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: ColorUtilities.light_300,
                    height: 110,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bella Rinova',
                            style: FontStyleUtilities.t2(
                              fontColor: widget.themeController.isDarkMode
                                  ? ColorUtilities.primary_400
                                  : ColorUtilities.primary_700,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "3 months ago" ?? '',
                            style: FontStyleUtilities.t5(
                              fontColor: widget.themeController.isDarkMode
                                  ? ColorUtilities.text_500
                                  : ColorUtilities.text_300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Sorry for the inconvenience, unfortunately we cannot see your name in out system around the day of the review! If you have been to Bella Rinova Hair Salon for a hair cut please get in touch with the front desk we will fix it for free !." ??
                            '',
                        style: FontStyleUtilities.p2(
                          fontColor: widget.themeController.isDarkMode
                              ? ColorUtilities.text_400
                              : ColorUtilities.text_600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String image;
  final String name;
  final int stars;
  final String timeAgo;
  final String review;
  const ReviewCard({
    Key key,
    @required this.themeController,
    this.image,
    this.name,
    this.stars,
    this.timeAgo,
    this.review,
  }) : super(key: key);

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imageUrl: image ?? '',
                isFromAssets: true,
                height: 36,
                width: 36,
                radius: BorderRadius.circular(50),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? '',
                      style: FontStyleUtilities.t2(
                        fontColor: themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                    SizedBox(height: 5),
                    getStars(themeController,
                        isDetailed: true, starCount: stars),
                  ],
                ),
              ),
              Text(
                timeAgo ?? '',
                style: FontStyleUtilities.t5(
                  fontColor: themeController.isDarkMode
                      ? ColorUtilities.text_500
                      : ColorUtilities.text_300,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            review ?? '',
            style: FontStyleUtilities.p2(
              fontColor: themeController.isDarkMode
                  ? ColorUtilities.text_400
                  : ColorUtilities.text_600,
            ),
          ),
        ],
      ),
    );
  }
}

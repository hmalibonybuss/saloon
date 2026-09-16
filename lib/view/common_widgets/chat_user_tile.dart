import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class ChatUserTile extends StatelessWidget {
  final String image;
  final String name;
  final String message;
  final String time;
  final int messageCount;
  final bool isOnline;
  final VoidCallback onPress;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  ChatUserTile(
      {Key key,
      this.image,
      this.name,
      this.message,
      this.time,
      this.messageCount,
      this.isOnline = false,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return GestureDetector(
            onTap: onPress ?? () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 60,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: ColorUtilities.transparant,
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CustomImageView(
                          imageUrl: image ?? AssetUtilities.chat01png,
                          isFromAssets: true,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(100),
                        ),
                        isOnline
                            ? Align(
                                alignment: Alignment(0.85, 0.85),
                                child: Container(
                                  height: 11,
                                  width: 11,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ColorUtilities.white,
                                      width: 2,
                                    ),
                                    color: ColorUtilities.green_500,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? '',
                          style: FontStyleUtilities.t1(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.white
                                : ColorUtilities.text_900,
                            fontWeight: FWT.semiBold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          message ?? '',
                          style: FontStyleUtilities.t3(
                            fontColor: _themeController.isDarkMode
                                ? ColorUtilities.text_500
                                : ColorUtilities.text_300,
                            fontWeight: FWT.regular,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        time ?? '',
                        style: FontStyleUtilities.t5(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.text_500
                              : ColorUtilities.text_300,
                          fontWeight: FWT.regular,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      messageCount == 0
                          ? SizedBox(height: 20)
                          : Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtilities.red_500,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                messageCount.toString() ?? '',
                                style: FontStyleUtilities.t5(
                                  fontColor: ColorUtilities.white,
                                  fontWeight: FWT.regular,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

/// ignore: must_be_immutable
class ChatDetailsScreen extends StatefulWidget {
  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackArrow(
                        color: _themeController.isDarkMode
                            ? ColorUtilities.dark_100
                            : ColorUtilities.text_900,
                        onBackTap: () {
                          Get.back();
                        },
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Angela Young',
                              style: FontStyleUtilities.h4(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.white
                                    : ColorUtilities.dark_900,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                            Text(
                              'Online',
                              style: FontStyleUtilities.t3(
                                fontColor: ColorUtilities.green_500,
                                fontWeight: FWT.regular,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomActionButton(
                        icon: AssetUtilities.phoneStrokeSvg,
                        iconSize: 15,
                        color: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.dark_900,
                        onTap: () {},
                      ),
                      SizedBox(width: 10),
                      CustomActionButton(
                        icon: AssetUtilities.videoStrokeSvg,
                        iconSize: 15,
                        color: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.dark_900,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ChatPopup(
                            senderType: SenderType.byMe,
                            chatType: ChatType.text,
                            message: "Oh, Hello Angela Young",
                          ),
                          ChatPopup(
                            senderType: SenderType.byMe,
                            chatType: ChatType.text,
                            message:
                                "I feel better than before. Should I need a haircut?",
                            time: "09:24 am",
                          ),
                          ChatPopup(
                            senderType: SenderType.byThem,
                            chatType: ChatType.text,
                            image: AssetUtilities.chat01png,
                            message:
                                "I will chack-in this evening at 7:30 pm. It is ok for you?",
                            time: "09:26 am",
                          ),
                          ChatPopup(
                            senderType: SenderType.byMe,
                            chatType: ChatType.text,
                            message:
                                "Yeah sure i will be there at 7 pm with my brother",
                            time: "09:27 am",
                          ),
                          ChatPopup(
                            senderType: SenderType.byThem,
                            chatType: ChatType.audio,
                            image: AssetUtilities.chat01png,
                            message:
                                "I will chack-in this evening at 7:30 pm. It is ok for you?",
                            time: "09:26 am",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: _themeController.isDarkMode
                              ? ColorUtilities.dark_800
                              : ColorUtilities.light_400,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: CustomSvgView(
                          imageUrl: AssetUtilities.closeStrokeSvg,
                          isFromAssets: true,
                          height: 15,
                          width: 15,
                          svgColor: _themeController.isDarkMode
                              ? ColorUtilities.dark_400
                              : ColorUtilities.text_900,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: _themeController.isDarkMode
                                ? ColorUtilities.dark_800
                                : ColorUtilities.light_400,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Write a message",
                                    hintStyle: FontStyleUtilities.t2(
                                      fontColor: _themeController.isDarkMode
                                          ? ColorUtilities.text_500
                                          : ColorUtilities.text_300,
                                      fontWeight: FWT.regular,
                                    ),
                                  ),
                                  style: FontStyleUtilities.t2(
                                    fontColor: _themeController.isDarkMode
                                        ? ColorUtilities.white
                                        : ColorUtilities.text_900,
                                    fontWeight: FWT.regular,
                                  ),
                                ),
                              ),
                              CustomSvgView(
                                imageUrl: AssetUtilities.sendStrokeSvg,
                                isFromAssets: true,
                                height: 20,
                                width: 20,
                                svgColor: _themeController.isDarkMode
                                    ? ColorUtilities.primary_400
                                    : ColorUtilities.primary_700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      {
                        "image": AssetUtilities.imageStrokeSvg,
                        "title": "Image",
                      },
                      {
                        "image": AssetUtilities.fileStrokeSvg,
                        "title": "File",
                      },
                      {
                        "image": AssetUtilities.micStrokeSvg,
                        "title": "Record",
                      },
                      {
                        "image": AssetUtilities.locationStrokeSvg,
                        "title": "Location",
                      },
                    ]
                        .map(
                          (e) => Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: _themeController.isDarkMode
                                            ? ColorUtilities.dark_800
                                            : ColorUtilities.light_400,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: CustomSvgView(
                                        imageUrl: e['image'],
                                        isFromAssets: true,
                                        height: 20,
                                        width: 20,
                                        svgColor: _themeController.isDarkMode
                                            ? ColorUtilities.dark_400
                                            : ColorUtilities.text_900,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      e['title'],
                                      style: FontStyleUtilities.t5(
                                        fontColor: _themeController.isDarkMode
                                            ? ColorUtilities.dark_400
                                            : ColorUtilities.text_900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

enum SenderType {
  byMe,
  byThem,
}

enum ChatType {
  text,
  audio,
  video,
}

/// ignore: must_be_immutable
class ChatPopup extends StatelessWidget {
  final SenderType senderType;
  final String message;
  final String image;
  final String time;
  final ChatType chatType;
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  ChatPopup({
    Key key,
    this.senderType = SenderType.byMe,
    this.message,
    this.image,
    this.time,
    this.chatType = ChatType.text,
  }) : super(key: key);

  bool checkCondition = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
        init: _themeController,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: senderType == SenderType.byMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                senderType == SenderType.byMe
                    ? SizedBox()
                    : Container(
                        height: 40,
                        width: 40,
                        child: Stack(
                          children: [
                            CustomImageView(
                              imageUrl: image ?? AssetUtilities.chat01png,
                              isFromAssets: true,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                              radius: BorderRadius.circular(100),
                            ),
                            checkCondition
                                ? Align(
                                    alignment: Alignment(0.95, 0.95),
                                    child: Container(
                                      height: 11,
                                      width: 11,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _themeController.isDarkMode
                                              ? ColorUtilities.dark_900
                                              : ColorUtilities.white,
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
                SizedBox(width: senderType == SenderType.byMe ? 0 : 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize.width / 1.5),
                  child: Column(
                    crossAxisAlignment: senderType == SenderType.byMe
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          color: senderType == SenderType.byMe
                              ? (_themeController.isDarkMode
                                  ? ColorUtilities.primary_400
                                  : ColorUtilities.primary_500)
                              : (_themeController.isDarkMode
                                  ? ColorUtilities.dark_800
                                  : ColorUtilities.light_300),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(
                                senderType == SenderType.byMe ? 0 : 20),
                            topLeft: Radius.circular(
                                senderType == SenderType.byMe ? 20 : 0),
                          ),
                        ),
                        child: chatType == ChatType.text
                            ? Text(
                                message ?? '',
                                style: FontStyleUtilities.t2(
                                    fontColor: senderType == SenderType.byMe
                                        ? ColorUtilities.white
                                        : (_themeController.isDarkMode
                                            ? ColorUtilities.white
                                            : ColorUtilities.text_900)),
                              )
                            : chatType == ChatType.audio
                                ? Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _themeController.isDarkMode
                                              ? ColorUtilities.primary_400
                                              : ColorUtilities.primary_500,
                                        ),
                                        alignment: Alignment.center,
                                        child: CustomSvgView(
                                          imageUrl: AssetUtilities.playSolidSvg,
                                          isFromAssets: true,
                                          height: 9,
                                          width: 9,
                                          svgColor: ColorUtilities.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: List.generate(60, (index) {
                                            Random r = Random();
                                            int length = r.nextInt(15);
                                            if (length <= 1) {
                                              length = 2;
                                            }
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 0.5),
                                              height: length.toDouble(),
                                              width: 1.5,
                                              color: _themeController.isDarkMode
                                                  ? ColorUtilities.dark_200
                                                  : ColorUtilities.primary_500,
                                            );
                                          }),
                                        ),
                                      ),
                                      Text(
                                        '1:00',
                                        style: FontStyleUtilities.t5(
                                          fontColor: _themeController.isDarkMode
                                              ? ColorUtilities.text_400
                                              : ColorUtilities.text_300,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                      ),
                      SizedBox(height: time == "" ? 0 : 10),
                      time == ""
                          ? SizedBox()
                          : Text(
                              time ?? '',
                              style: FontStyleUtilities.t5(
                                fontColor: _themeController.isDarkMode
                                    ? ColorUtilities.text_500
                                    : ColorUtilities.text_300,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

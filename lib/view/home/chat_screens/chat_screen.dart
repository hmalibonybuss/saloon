import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';
import 'package:saloon_app/view/home/chat_screens/chat_details_screen.dart';
import 'package:saloon_app/view/home/search_screen.dart';

/// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  List<Map> chatTablist = [
    {
      "title": "Message",
      "isSelected": true,
    },
    {
      "title": "Active",
      "isSelected": false,
    },
    {
      "title": "Group",
      "isSelected": false,
    },
    {
      "title": "Calls",
      "isSelected": false,
    }
  ];

  List<Map> userTileList = [
    {
      "image": AssetUtilities.chat01png,
      "name": "Angela Young",
      "message": "Hello, How can I help you ?",
      "lastSeen": "10:32",
      "newMessage": 1,
      "isOnline": true,
    },
    {
      "image": AssetUtilities.chat02png,
      "name": "Steve Didko",
      "message": "When will I do next facial ...",
      "lastSeen": "8:06",
      "newMessage": 3,
      "isOnline": false,
    },
    {
      "image": AssetUtilities.chat03png,
      "name": "Andrew Bolton",
      "message": "Wow, awesome! Thank you...",
      "lastSeen": "Yesterday",
      "newMessage": 0,
      "isOnline": false,
    },
    {
      "image": AssetUtilities.chat04png,
      "name": "Jeremy Runner",
      "message": "Hello, How can I change Hair color ?",
      "lastSeen": "3 Jun",
      "newMessage": 0,
      "isOnline": true,
    },
    {
      "image": AssetUtilities.chat05png,
      "name": "Esther Howard",
      "message": "Sounds good to me!",
      "lastSeen": "25 Feb",
      "newMessage": 0,
      "isOnline": false,
    },
    {
      "image": AssetUtilities.chat06png,
      "name": "Kathryn Murphy",
      "message": "How's your hair color now asd asd asd asd a asd ads as a sd?",
      "lastSeen": "10 Feb",
      "newMessage": 0,
      "isOnline": false,
    },
    {
      "image": AssetUtilities.chat07png,
      "name": "Cody Fisher",
      "message": "Which kind of package and offer do you provide ?",
      "lastSeen": "8 Jan",
      "newMessage": 0,
      "isOnline": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Scaffold(
          backgroundColor: _themeController.isDarkMode
              ? ColorUtilities.dark_900
              : ColorUtilities.white,
          body: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Text(
                      '2 new messages',
                      style: FontStyleUtilities.h4(
                        fontColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.dark_900,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                    Spacer(),
                    CustomActionButton(
                      icon: AssetUtilities.searchStrokeSvg,
                      iconSize: 15,
                      color: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.dark_900,
                      onTap: () {
                        Get.to(SearchScreen());
                      },
                    ),
                    SizedBox(width: 10),
                    CustomActionButton(
                      icon: AssetUtilities.settingsStrokeSvg,
                      iconSize: 15,
                      color: _themeController.isDarkMode
                          ? ColorUtilities.white
                          : ColorUtilities.dark_900,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    chatTablist.length,
                    (index) {
                      Map service = chatTablist[index];
                      return CommonChip(
                        title: service["title"],
                        radius: 30,
                        isSelected: service["isSelected"],
                        chipType: ChipType.simple,
                        activeColor: _themeController.isDarkMode
                            ? ColorUtilities.white
                            : ColorUtilities.text_900,
                        inactiveColor: ColorUtilities.transparant,
                        onChipTap: (bool isSelected) {
                          setState(() {
                            chatTablist.forEach((element) {
                              element["isSelected"] = false;
                            });
                            chatTablist[index]["isSelected"] = isSelected;
                          });
                          _pageController.jumpToPage(index);
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                              children: userTileList
                                  .map(
                                    (e) => ChatUserTile(
                                      image: e['image'],
                                      isOnline: e['isOnline'],
                                      message: e['message'],
                                      name: e['name'],
                                      messageCount: e['newMessage'],
                                      time: e['lastSeen'],
                                      onPress: () {
                                        Get.to(ChatDetailsScreen());
                                      },
                                    ),
                                  )
                                  .toList()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
              height: 70,
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

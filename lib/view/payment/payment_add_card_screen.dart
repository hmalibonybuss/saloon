import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

class PaymentAddCardScreen extends StatefulWidget {
  @override
  _PaymentAddCardScreenState createState() => _PaymentAddCardScreenState();
}

class _PaymentAddCardScreenState extends State<PaymentAddCardScreen>
    with TickerProviderStateMixin {
  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  AnimationController _cardAnimationController;
  Animation _cardAnimation;
  bool isCvvShow = false;

  TextEditingController _cardNumber = TextEditingController();
  TextEditingController _cardHolderName = TextEditingController();
  TextEditingController _cardExpieryDate = TextEditingController();
  TextEditingController _cardCvvNumber = TextEditingController();

  String _getCardNumber(TextEditingController controller) {
    String number = "";
    for (int i = 1; i <= controller.text.length; i++) {
      if (i == 4 || i == 8 || i == 12) {
        number = number + controller.text[i - 1] + "   ";
      } else {
        number = number + controller.text[i - 1];
      }
    }
    return number;
  }

  @override
  void initState() {
    _cardAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      reverseDuration: Duration(
        milliseconds: 300,
      ),
    );

    _cardAnimation =
        Tween<double>(begin: 0, end: 3.14).animate(_cardAnimationController);
    super.initState();
  }

  bool inProcess = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: _themeController.isDarkMode
                ? ColorUtilities.dark_900
                : ColorUtilities.white,
            body: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        'Add Card',
                        style: FontStyleUtilities.h3(
                          fontColor: _themeController.isDarkMode
                              ? ColorUtilities.white
                              : ColorUtilities.text_900,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: ColorUtilities.transparant,
                          child: CustomSvgView(
                            imageUrl: AssetUtilities.closeStrokeSvg,
                            isFromAssets: true,
                            height: 13,
                            width: 13,
                            svgColor: _themeController.isDarkMode
                                ? ColorUtilities.dark_100
                                : ColorUtilities.text_900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                AnimatedBuilder(
                    animation: _cardAnimation,
                    builder: (context, snapshot) {
                      return Container(
                        height: 190,
                        width: screenSize.width,
                        child: Stack(
                          children: [
                            Transform(
                              alignment: Alignment.center,
                              transform:
                                  Matrix4.rotationY(_cardAnimation.value),
                              child: Container(
                                height: 190,
                                width: screenSize.width,
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  color: ColorUtilities.primary_500,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            Container(
                              height: 190,
                              width: screenSize.width,
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: ColorUtilities.transparant,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Visibility(
                                visible: !inProcess,
                                child: isCvvShow
                                    ? Center(
                                        child: Container(
                                          height: 40,
                                          width: screenSize.width / 1.5,
                                          color: ColorUtilities.dark_200,
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 40,
                                            width: 60,
                                            color: ColorUtilities.white,
                                            alignment: Alignment.center,
                                            child: Text(
                                              _cardCvvNumber.text != ""
                                                  ? _cardCvvNumber.text
                                                  : 'CVV',
                                              style: FontStyleUtilities.h4(
                                                fontColor:
                                                    ColorUtilities.text_900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomImageView(
                                                imageUrl:
                                                    AssetUtilities.chipPng,
                                                isFromAssets: true,
                                                width: 36,
                                                height: 28,
                                              ),
                                              Spacer(),
                                              CustomImageView(
                                                imageUrl: AssetUtilities
                                                    .visaCardDarkPaymentPng,
                                                isFromAssets: true,
                                                width: 52,
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            _cardNumber.text != ""
                                                ? _getCardNumber(_cardNumber)
                                                : "0000   0000   0000   0000",
                                            style: FontStyleUtilities.h4(
                                              fontColor: ColorUtilities.white,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Card holder",
                                                    style:
                                                        FontStyleUtilities.t4(
                                                      fontColor: ColorUtilities
                                                          .white
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                    _cardHolderName
                                                                    .text !=
                                                                ""
                                                        ? _cardHolderName.text
                                                        : "Jenny Wilson",
                                                    style:
                                                        FontStyleUtilities.t4(
                                                      fontColor:
                                                          ColorUtilities.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Expiers",
                                                    style:
                                                        FontStyleUtilities.t4(
                                                      fontColor: ColorUtilities
                                                          .white
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                    _cardExpieryDate
                                                                    .text !=
                                                                ""
                                                        ? _cardExpieryDate.text
                                                        : "02/2021",
                                                    style:
                                                        FontStyleUtilities.t4(
                                                      fontColor:
                                                          ColorUtilities.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Card number',
                            style: FontStyleUtilities.t1(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.regular,
                            ),
                          ),
                          SizedBox(height: 5),
                          CustomTextField(
                            controller: _cardNumber,
                            hint: "4950 4545 1234 9876",
                            icon: AssetUtilities.creditCardStrokeSvg,
                            keyboardType: TextInputType.number,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(16)
                            ],
                            onChange: (String value) {
                              setState(() {});
                            },
                            onTap: () {
                              if (isCvvShow) {
                                setState(() {
                                  inProcess = true;
                                  _cardAnimationController
                                      .reverse()
                                      .then((value) {
                                    inProcess = false;
                                    isCvvShow = false;
                                  });
                                });
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Card holder',
                            style: FontStyleUtilities.t1(
                              fontColor: _themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900,
                              fontWeight: FWT.regular,
                            ),
                          ),
                          SizedBox(height: 5),
                          CustomTextField(
                            controller: _cardHolderName,
                            hint: "Jenny Wilson",
                            keyboardType: TextInputType.name,
                            onChange: (String value) {
                              setState(() {});
                            },
                            onTap: () {
                              if (isCvvShow) {
                                setState(() {
                                  inProcess = true;
                                  _cardAnimationController
                                      .reverse()
                                      .then((value) {
                                    inProcess = false;
                                    isCvvShow = false;
                                  });
                                });
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  Text(
                                    'Exp Date',
                                    style: FontStyleUtilities.t1(
                                      fontColor: _themeController.isDarkMode
                                          ? ColorUtilities.white
                                          : ColorUtilities.text_900,
                                      fontWeight: FWT.regular,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  CustomTextField(
                                    controller: _cardExpieryDate,
                                    hint: "DD.MM.YYYYY",
                                    width: ((screenSize.width - 60) / 2),
                                    keyboardType: TextInputType.datetime,
                                    onChange: (String value) {
                                      setState(() {});
                                    },
                                    onTap: () {
                                      if (isCvvShow) {
                                        setState(() {
                                          inProcess = true;
                                          _cardAnimationController
                                              .reverse()
                                              .then((value) {
                                            inProcess = false;
                                            isCvvShow = false;
                                          });
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  Text(
                                    'CVV',
                                    style: FontStyleUtilities.t1(
                                      fontColor: _themeController.isDarkMode
                                          ? ColorUtilities.white
                                          : ColorUtilities.text_900,
                                      fontWeight: FWT.regular,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  CustomTextField(
                                    controller: _cardCvvNumber,
                                    hint: "000",
                                    width: ((screenSize.width - 60) / 2),
                                    keyboardType: TextInputType.number,
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                    onChange: (String value) {
                                      setState(() {});
                                    },
                                    onTap: () {
                                      if (!isCvvShow) {
                                        setState(() {
                                          inProcess = true;
                                          _cardAnimationController
                                              .forward()
                                              .then((value) {
                                            inProcess = false;
                                            isCvvShow = true;
                                          });
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CustomCheckBox(
                                onChange: (bool isSelected) {},
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Set as your default payment method',
                                style: FontStyleUtilities.t3(
                                  fontColor: _themeController.isDarkMode
                                      ? ColorUtilities.primary_400
                                      : ColorUtilities.primary_500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          CustomButton(
                            title: "Add",
                            width: screenSize.width,
                            onButtonTap: () {
                              Get.back();
                            },
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

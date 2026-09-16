import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saloon_app/controller/theme/theme_controller.dart';
import 'package:saloon_app/utilities/utilities.dart';

typedef OnSubmitOTP = Function(String);

/// ignore: must_be_immutable
class OTPField extends StatefulWidget {
  final OnSubmitOTP onSubmit;
  final int otpLength;
  OTPField({
    required Key key,
    required this.otpLength,
    required this.onSubmit,
  })  : assert(otpLength >= 2 && otpLength <= 6),
        super(key: key);

  int currentSelectedField = 0;
  bool otpComplete = false;

  @override
  OTPFieldState createState() => OTPFieldState();
}

class OTPFieldState extends State<OTPField> with TickerProviderStateMixin {
  List<TextEditingController> otpControllerList = [];
  List<FocusNode> focusNodeList = [];
  List<AnimationController> animationControllerList = [];
  List<Animation> animationList = [];

  ThemeController _themeController =
      Get.find(tag: ThemeController().toString());

  generateOTPControllerList(int length) {
    for (int i = 0; i < length; i++) {
      otpControllerList.add(TextEditingController(text: "-"));
      focusNodeList.add(FocusNode());
      animationControllerList.add(
        AnimationController(
          vsync: this,
          duration: Duration(milliseconds: (500 + (i * 100))),
          reverseDuration: Duration(milliseconds: (300 + (i * 100))),
        ),
      );

      animationList.add(
        Tween(begin: 0.0, end: 30.0).animate(
          animationControllerList[i],
        ),
      );
      animationControllerList[i]
          .forward()
          .whenComplete(() => animationControllerList[i].reverse());
    }
  }

  disposeControllers(int length) {
    for (int i = 0; i < length; i++) {
      animationControllerList[i].dispose();
    }
  }

  String getOtp(int length) {
    String otp = "";
    for (int i = 0; i < length; i++) {
      otp = otp + otpControllerList[i].text;
    }
    return otp;
  }

  @override
  void initState() {
    super.initState();
    generateOTPControllerList(widget.otpLength);
  }

  @override
  void dispose() {
    disposeControllers(widget.otpLength);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: _themeController,
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            otpControllerList.length,
            (index) => AnimatedBuilder(
                animation: animationList[index],
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, animationList[index].value),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: _themeController.isDarkMode
                            ? (widget.currentSelectedField == index
                                ? ColorUtilities.dark_900
                                : ColorUtilities.dark_800)
                            : (widget.currentSelectedField == index
                                ? ColorUtilities.white
                                : ColorUtilities.light_300),
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                          color: widget.otpComplete
                              ? ColorUtilities.green_500
                              : (_themeController.isDarkMode
                                  ? ColorUtilities.dark_800
                                  : ColorUtilities.transparant),
                          width: 2,
                        ),
                        boxShadow: [
                          widget.currentSelectedField == index &&
                                  !_themeController.isDarkMode
                              ? BoxShadow(
                                  color: ColorUtilities.black,
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                  spreadRadius: -15,
                                )
                              : BoxShadow(
                                  color: ColorUtilities.transparant,
                                ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      alignment: Alignment.center,
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        controller: otpControllerList[index],
                        focusNode: focusNodeList[index],
                        style: TextStyle(
                          color: otpControllerList[index].text != "" &&
                                  otpControllerList[index].text != "-"
                              ? (_themeController.isDarkMode
                                  ? ColorUtilities.white
                                  : ColorUtilities.text_900)
                              : (_themeController.isDarkMode
                                  ? ColorUtilities.dark_500
                                  : ColorUtilities.text_900),
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        cursorColor: otpControllerList[index].text != ""
                            ? (_themeController.isDarkMode
                                ? ColorUtilities.primary_500
                                : ColorUtilities.text_900)
                            : (_themeController.isDarkMode
                                ? ColorUtilities.primary_500
                                : ColorUtilities.text_900),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        keyboardType: TextInputType.number,
                        // ignore: deprecated_member_use
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        onChanged: (value) {
                          if (value.length >= 1) {
                            widget.currentSelectedField++;
                            FocusScope.of(context).nextFocus();
                          } else if (value.length == 0) {
                            widget.currentSelectedField--;
                            FocusScope.of(context).previousFocus();
                          }
                          if (index == widget.otpLength - 1) {
                            String otp = getOtp(widget.otpLength);
                            if (otp.length == widget.otpLength) {
                              widget.otpComplete = true;
                              for (int i = 0;
                                  i < animationControllerList.length;
                                  i++) {
                                animationControllerList[i]
                                    .forward()
                                    .whenComplete(() =>
                                        animationControllerList[i].reverse());
                              }
                              widget.onSubmit(otp);
                            }
                          } else {
                            widget.otpComplete = false;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}

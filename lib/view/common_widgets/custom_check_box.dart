import 'package:flutter/material.dart';
import 'package:saloon_app/utilities/utilities.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

typedef OnChange = void Function(bool);

/// ignore: must_be_immutable
class CustomCheckBox extends StatefulWidget {
  final double size;
  bool isSelected;
  final OnChange onChange;

  CustomCheckBox(
      {Key key, this.size, this.isSelected = false, @required this.onChange})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });

        widget.onChange(widget.isSelected);
      },
      child: Container(
        height: widget.size ?? 20,
        width: widget.size ?? 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? ColorUtilities.primary_500
              : ColorUtilities.light_500,
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget.isSelected
            ? CustomSvgView(
                imageUrl: AssetUtilities.checkTrueStrokeSvg,
                isFromAssets: true,
                height: 11,
                width: 11,
                svgColor: ColorUtilities.white,
              )
            : SizedBox(),
      ),
    );
  }
}

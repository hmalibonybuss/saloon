import 'package:flutter/material.dart';
import 'package:saloon_app/utilities/asset_utils.dart';

/// THIS IS THE CLASS FOR SHOW IMAGES...
/// ignore: must_be_immutable
class CustomImageView extends StatelessWidget {
  final String imageUrl;
  final bool isFromAssets;
  final double height;
  final double width;
  final BoxFit fit;
  final BorderRadius radius;

  const CustomImageView(
      {Key key,
      this.imageUrl,
      this.isFromAssets = true,
      this.height,
      this.width,
      this.fit,
      this.radius})
      : assert(imageUrl != "");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius ?? BorderRadius.circular(0),
        // color: ColorUtilities.primary_050,
      ),
      child: ClipRRect(
          borderRadius: radius ?? BorderRadius.circular(0),
          child: isFromAssets ?? true
              ? Image.asset(
                  imageUrl,
                  height: height ?? null,
                  width: width ?? null,
                  fit: fit ?? BoxFit.contain,
                  errorBuilder:
                      (BuildContext context, Object obj, StackTrace st) =>
                          Image.asset(
                    AssetUtilities.applicationlogo,
                    height: height ?? null,
                    width: width ?? null,
                    fit: fit ?? BoxFit.contain,
                  ),
                )
              : Image.network(
                  imageUrl,
                  height: height ?? null,
                  width: width ?? null,
                  fit: fit ?? BoxFit.contain,
                  errorBuilder:
                      (BuildContext context, Object obj, StackTrace st) =>
                          Image.asset(
                    AssetUtilities.applicationlogo,
                    height: height ?? null,
                    width: width ?? null,
                    fit: fit ?? BoxFit.contain,
                  ),
                )),
    );
  }
}

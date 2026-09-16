import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:saloon_app/utilities/asset_utils.dart';
import 'package:saloon_app/view/common_widgets/common_widgets.dart';

class GalleryTab extends StatelessWidget {
  final List<String> imageList = [
    AssetUtilities.gallary01Png,
    AssetUtilities.gallary02Png,
    AssetUtilities.gallary03Png,
    AssetUtilities.gallary04Png,
    AssetUtilities.gallary05Png,
    AssetUtilities.gallary06Png,
    AssetUtilities.gallary07Png,
    AssetUtilities.gallary08Png,
  ];
  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      children: imageList
          .asMap()
          .entries
          .map((item) => StaggeredGridTile.count(
                mainAxisCellCount: 2,
                crossAxisCellCount: item.key.isEven ? 2 : 1,
                child: CustomImageView(
                  imageUrl: item.value,
                  isFromAssets: true,
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

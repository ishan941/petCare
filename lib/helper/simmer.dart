import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:shimmer/shimmer.dart';

// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'path_to_color_util.dart'; // Import your ColorUtil file

class SimmerEffect {
  static Widget shimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: _buildShimmerContainer(100, 100),
        title: _buildShimmerContainer(10, double.infinity),
        subtitle: _buildShimmerContainer(100, double.infinity),
      ),
    );
  }
  static Widget shimemrForShop() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        
        leading: _buildShimmerContainer(200, 200),
        title: _buildShimmerContainer(100, double.infinity),
        subtitle: _buildShimmerContainer(10, double.infinity),
      ),
    );
  }

  static Widget _buildShimmerContainer(double height, double width) {
    return Container(
      color: ColorUtil.BackGroundColorColor,
      height: height,
      width: width,
    );
  }
}

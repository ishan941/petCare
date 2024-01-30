import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:shimmer/shimmer.dart';

class SimmerEffect {
   static simmerEffect(context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        
        leading: Container(
          height: 100,
          width: 100,
          color: ColorUtil.BackGroundColorColor,
        ),
        title: Container(
          color: Colors.white,
          height: 10,
        ),
        subtitle: Container(
          color: Colors.white,
          height: 100,
        ),
      ),
    );
  }
}
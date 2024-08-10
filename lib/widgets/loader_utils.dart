import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../network/constants.dart';


shimmerLoader(
    {required double height, required double width, double radius = 3.0}) {
  return SizedBox(
    width: width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: const ColoredBox(color: appColorPrimaryDarkLight),
    ),
  );
}

Widget titleShimmerLoader(
    {required double width,
    required double height,
    double radius = 6,
    double padding = 20}) {
  return Padding(
    padding: EdgeInsets.only(left: padding),
    child: Shimmer.fromColors(
      child: shimmerLoader(height: height, width: width, radius: radius),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    ),
  );
}

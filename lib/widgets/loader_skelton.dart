import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/utils/size_utils.dart';
import 'loader_utils.dart';

class ListAdapterSkelton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    shimmerLoader(
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        shimmerLoader(
                          width: SizeUtils.width - 160,
                          height: 25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        shimmerLoader(
                          width: SizeUtils.width - 160,
                          height: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

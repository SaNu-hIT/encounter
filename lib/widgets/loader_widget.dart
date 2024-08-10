import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/utils/size_utils.dart';
import 'loader_skelton.dart';
import 'loader_utils.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: true,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          shimmerLoader(width: 40, height: 40, radius: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          shimmerLoader(
                            width: 100,
                            height: 15,
                          ),
                          Spacer(),
                          shimmerLoader(width: 24, height: 24, radius: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Wrap(
              children: List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListAdapterSkelton(),
            ),
          ))
        ],
      ),
    );
  }
}

class LoaderHomeWidget extends StatelessWidget {
  const LoaderHomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(25),
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
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        shimmerLoader(width: 40, height: 40, radius: 20),
                        const SizedBox(
                          width: 10,
                        ),
                        shimmerLoader(
                          width: 100,
                          height: 15,
                        ),
                        Spacer(),
                        shimmerLoader(width: 24, height: 24, radius: 12),
                        const SizedBox(
                          width: 10,
                        ),
                        shimmerLoader(width: 24, height: 24, radius: 12),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    shimmerLoader(
                        width: SizeUtils.width, height: 170, radius: 22),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 items per row
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return shimmerLoader(
                              width: SizeUtils.width, height: 10, radius: 16);
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    shimmerLoader(
                      width: 200,
                      height: 25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            shimmerLoader(width: 40, height: 40, radius: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            shimmerLoader(
                              width: 100,
                              height: 15,
                            ),
                            Spacer(),
                            shimmerLoader(width: 24, height: 24, radius: 12),
                            const SizedBox(
                              width: 10,
                            ),
                            shimmerLoader(width: 24, height: 24, radius: 12),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        shimmerLoader(width: SizeUtils.width, height: 20),
                        SizedBox(
                          height: 10,
                        ),
                        shimmerLoader(
                          width: SizeUtils.width,
                          height: 40,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            shimmerLoader(width: 40, height: 40, radius: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            shimmerLoader(
                              width: 100,
                              height: 15,
                            ),
                            Spacer(),
                            shimmerLoader(width: 24, height: 24, radius: 12),
                            const SizedBox(
                              width: 10,
                            ),
                            shimmerLoader(width: 24, height: 24, radius: 12),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        shimmerLoader(width: SizeUtils.width, height: 20),
                        SizedBox(
                          height: 10,
                        ),
                        shimmerLoader(
                          width: SizeUtils.width,
                          height: 40,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}

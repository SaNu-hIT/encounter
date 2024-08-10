import 'package:encounter_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_image_view.dart';
import '../models/explorecommentary_item_model.dart'; // ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ExplorecommentaryItemWidget extends StatelessWidget {
  ExplorecommentaryItemWidget(this.explorecommentaryItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ExplorecommentaryItemModel explorecommentaryItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 198, 229, 249),
          borderRadius: BorderRadius.all(
            Radius.circular(
                0.1 * 71.h), // 10% curve (0.1 times the width of the container)
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: explorecommentaryItemModelObj.dynamicImage!,
                height: 38.v,
                width: 40.h,
              ),
              SizedBox(height: 9.v),
              SizedBox(
                child: Text(
                  explorecommentaryItemModelObj.dynamicText!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge!.copyWith(
                    height: 1.33,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:encounter_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../../widgets/custom_image_view.dart';
import '../../home_container_screen/provider/home_container_provider.dart';
import '../models/explorecommentary_item_model.dart';
// ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ExplorecommentaryItemWidget extends StatelessWidget {
  ExplorecommentaryItemWidget(this.model, {Key? key})
      : super(
          key: key,
        );

  ExplorecommentaryItemModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (model.id == BottomBarEnum.Notes) {
          NavigatorService.pushNamed(
            AppRoutes.my_notes,
          );
        } else {
          Provider.of<HomeContainerProvider>(context, listen: false)
              .selectTab(model.id!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.8,
          decoration: BoxDecoration(
            color: appTheme.gridBg.withOpacity(0.25),
            borderRadius: BorderRadius.all(
              Radius.circular(
                  10), // 10% curve (0.1 times the width of the container)
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(5.v),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: model.dynamicImage!,
                  height: 32.v,
                  width: 32.h,
                ),
                SizedBox(height: 9.v),
                SizedBox(
                  child: Text(
                    model.dynamicText!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallBluegray90002,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

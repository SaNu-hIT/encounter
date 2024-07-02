import 'package:encounter_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_text_style.dart';
import '../../../widgets/custom_image_view.dart';
import '../models/viewhierarchy_item_model.dart'; // ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ViewhierarchyItemWidget extends StatelessWidget {
  ViewhierarchyItemWidget(this.viewhierarchyItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ViewhierarchyItemModel viewhierarchyItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeUtils.width / 2.2,
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: viewhierarchyItemModelObj.image!,
              height: 156.adaptSize,
              width: 156.adaptSize,
              radius: BorderRadius.circular(
                5.h,
              ),
            ),
            SizedBox(height: 9.v),
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: Text(
                viewhierarchyItemModelObj.text1!,
                style: CustomTextStyles.titleSmallBluegray900,
              ),
            ),
            SizedBox(height: 3.v),
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: Text(
                viewhierarchyItemModelObj.text2!,
                style: CustomTextStyles.labelLargeManropeTeal800,
              ),
            )
          ],
        ),
      ),
    );
  }
}

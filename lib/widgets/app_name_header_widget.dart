import 'package:encounter_app/core/app_export.dart';
import 'package:flutter/material.dart';

class AppNameHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageView(
          imagePath: ImageConstant.logo_blue,
        ),
        SizedBox(
          height: 20,
        )
        // Text(
        //   "lbl_encounter".tr,
        //   style: CustomTextStyles.displaySmallCanelaTrial24,
        // ),
        // SizedBox(
        //   height: 1,
        // ),
        // Text(
        //   "lbl_study_bible".tr,
        //   style: CustomTextStyles.displaySmallCanelaTrial20,
        // ),
      ],
    );
  }
}

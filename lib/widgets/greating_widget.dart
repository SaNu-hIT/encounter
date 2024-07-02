import 'package:encounter_app/core/app_export.dart';
import 'package:flutter/material.dart';

class GreatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "lbl_greetings_from".tr,
          style: CustomTextStyles.labelLargeManropeWhiteTitle,
        ),
        SizedBox(height: 3.v),
        Text(
          "lbl_encounter_app".tr,
          style: CustomTextStyles.labelLargeManropeWhiteHeading,
        ),
        SizedBox(height: 8.v),
      ],
    );
  }
}

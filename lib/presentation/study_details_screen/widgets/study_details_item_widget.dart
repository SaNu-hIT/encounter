import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/study_details_item_model.dart'; // ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class StudyDetailsItemWidget extends StatelessWidget {
  StudyDetailsItemWidget(this.studyDetailsItemModelObj, {Key? key})
      : super(
          key: key,
        );

  StudyDetailsItemModel studyDetailsItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
      child: CustomImageView(
        imagePath: studyDetailsItemModelObj.rectangle!,
        height: 106.v,
        width: 128.h,
        radius: BorderRadius.circular(
          10.h,
        ),
      ),
    );
  }
}

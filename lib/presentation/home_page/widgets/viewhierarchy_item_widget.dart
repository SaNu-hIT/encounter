import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/home_respo.dart';

class CourseListWidget extends StatelessWidget {
  CourseListWidget(this.listItem, {Key? key})
      : super(
          key: key,
        );

  BibileList listItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.studyDetailsScreen,
            arguments: listItem.id.toString());
      },
      child: SizedBox(
        width: SizeUtils.width / 2.2,
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: listItem.image,
                height: 156.adaptSize,
                width: 156.adaptSize,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(
                  12.h,
                ),
              ),
              SizedBox(height: 9.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  listItem.data1!,
                  style: CustomTextStyles.titleSmallBluegray900,
                ),
              ),
              SizedBox(height: 3.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  listItem.data2!,
                  style: CustomTextStyles.labelLargeManropeTeal800,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

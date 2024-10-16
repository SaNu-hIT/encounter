import 'package:auto_size_text/auto_size_text.dart';
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
        print("DATA${listItem.id}");
        NavigatorService.pushNamed(AppRoutes.studyDetailsScreen,
            arguments: listItem.id.toString());
      },
      child: SizedBox(
        width: SizeUtils.width / 2.3,
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CustomImageView(
                    imagePath: listItem.image,
                    height: 156.adaptSize,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(
                      8.h,
                    ),
                  ),
                  listItem.data4 != ""
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            children: [
                              Spacer(),
                              Container(
                                  decoration: BoxDecoration(
                                    color: appTheme.amber700,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(8.h)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      listItem.data4 ?? "",
                                      style: CustomTextStyles
                                          .labelManropeWhiteSemi14,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 2.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: SizedBox(
                  width: SizeUtils.width / 2.2,
                  child: AutoSizeText(
                    "${listItem.data1} : ${listItem.data3}",
                    style: CustomTextStyles.titleSmallBluegray900,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(height: 3.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: AutoSizeText(
                  listItem.data2!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
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

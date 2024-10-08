import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import 'models/course_detail_respo.dart';
import 'provider/full_course_provider.dart';

class CourseFullScreen extends StatefulWidget {
  const CourseFullScreen({Key? key})
      : super(
          key: key,
        );

  @override
  CourseFullScreenState createState() => CourseFullScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FullCourseProvider(),
      child: CourseFullScreen(),
    );
  }
}

class CourseFullScreenState extends State<CourseFullScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      String course_id = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<FullCourseProvider>(context, listen: false)
          .getFullCourse(course_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FullCourseProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderWidget();
      }
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              "All Courses",
              style: CustomTextStyles.titleLargeManropeHead,
            ),
          ),
          backgroundColor: appTheme.backgroundColor,
          body: _buildRowDay(context, provider));
    });
  }

  Widget _buildRowDayOne(BuildContext context, CourseContent model) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.h),
        padding: EdgeInsets.symmetric(
          horizontal: 11.h,
          vertical: 15.v,
        ),
        decoration: BoxDecoration(
            // color:  Color.fromARGB(255, 143, 187, 226),
            border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 143, 187, 226),
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      "lbl_day".tr,
                      style: CustomTextStyles.bodyMediumBluegray900,
                    ),
                  ),
                  Text(
                    model.day.toString(),
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(
                    model.readStatus == true ? "COMPLETE" : "PENDING",
                    style: CustomTextStyles.bodyMediumBluegray90010,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: SizedBox(
                height: 48.v,
                child: VerticalDivider(
                  width: 1.h,
                  thickness: 1.v,
                  color: appTheme.black900.withOpacity(0.2),
                  indent: 5.h,
                  endIndent: 5.h,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  top: 4.v,
                  bottom: 4.v,
                ),
                // Build a column with a list of Text widgets from the details list
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: model.details!.map<Widget>((detail) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0), // Add spacing between text
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              detail
                                  .toString(), // Convert each detail to string if necessary
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: appTheme.blueGray90002,
                              ), // Customize the text style if needed
                              maxLines:
                                  1, // Ensure the text stays in a single line
                              overflow: TextOverflow
                                  .ellipsis, // Add ellipsis if the text exceeds one line
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(), // Convert the Iterable to a List of Widgets
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgVector,
              height: 10.v,
              width: 10.h,
              margin: EdgeInsets.fromLTRB(7.h, 22.v, 12.h, 22.v),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowDay(BuildContext context, FullCourseProvider provider) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: provider.respo.data?.first.courseContent?.length ?? 0,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            CourseContent model =
                provider.respo.data?.first.courseContent?[index] ??
                    CourseContent();
            return GestureDetector(
                onTap: () {
                  NavigatorService.pushNamed(
                    AppRoutes.studyDayScreen,
                    arguments: {
                      'course_day_id': model.courseContentId.toString(),
                      'day': model.day.toString(),
                      'userLmsId':
                          provider.respo.data?.first.userLmsId.toString(),
                    },
                  ).then((val) => provider.getFullCourse(provider.course_id));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildRowDayOne(context, model),
                ));
          },
        ),
      ],
    );
  }

  /// Section Widget

  /// Common widget
  Widget _buildColumngenesis(
    BuildContext context, {
    required String titleText,
    required String chapterText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: theme.textTheme.titleMedium?.copyWith(
            color: appTheme.blueGray90002,
          ),
        ),
        SizedBox(height: 1.v),
        Text(
          chapterText,
          style: CustomTextStyles.bodyMediumGray60001.copyWith(
            color: appTheme.gray60001,
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowEyeOne(
    BuildContext context, {
    required String monthText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            monthText,
            style: CustomTextStyles.labelLargeManropeBluegray90003.copyWith(
              color: appTheme.blueGray90003.withOpacity(0.76),
            ),
          ),
        ),
        CustomIconButton(
          height: 20.adaptSize,
          width: 20.adaptSize,
          padding: EdgeInsets.all(6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgEye,
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}

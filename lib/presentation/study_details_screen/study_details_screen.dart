import 'package:auto_size_text/auto_size_text.dart';
import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'models/course_detail_respo.dart';
import 'models/study_details_item_model.dart';
import 'models/study_details_model.dart';
import 'provider/study_details_provider.dart';
import 'widgets/study_details_item_widget.dart';

class StudyDetailsScreen extends StatefulWidget {
  const StudyDetailsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  StudyDetailsScreenState createState() => StudyDetailsScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudyDetailsProvider(),
      child: StudyDetailsScreen(),
    );
  }
}

class StudyDetailsScreenState extends State<StudyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
        //color set to transperent or set your own color
        ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String course_id = ModalRoute.of(context)!.settings.arguments as String;
      Provider.of<StudyDetailsProvider>(context, listen: false)
          .getDetails(course_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyDetailsProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderHomeWidget();
      }
      return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 270.0,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: _buildStackArrowLeft(context, provider),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.h, top: 13),
                      child: SizedBox(
                        width: SizeUtils.width / 1.2,
                        child: Row(
                          children: [
                            AutoSizeText(
                              provider.respo.data?.first.courseName ?? "",
                              style: CustomTextStyles.titleLargeManrope,
                            ),
                            AutoSizeText(
                              ": ${provider.respo.data?.first.batchName ?? ""}",
                              style: CustomTextStyles.titleLargeManrope,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.h,
                        right: 24.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: Text(
                              " Start on ${provider.respo.data?.first.startDate ?? ""}",
                              style: CustomTextStyles.titleSmallBluegray500,
                            ),
                          ),
                          Container(
                            height: 4.adaptSize,
                            width: 4.adaptSize,
                            margin: EdgeInsets.only(
                              left: 9.h,
                              top: 9.v,
                              bottom: 8.v,
                            ),
                            decoration: BoxDecoration(
                              color: appTheme.amber700,
                              borderRadius: BorderRadius.circular(
                                2.h,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: SizedBox(
                              width: SizeUtils.width / 2.4,
                              child: AutoSizeText(
                                "Enrolment Last date ${provider.respo.data?.first.endDate ?? ""}",
                                style: CustomTextStyles.bodyMediumGray500,
                                maxLines: 2,
                                minFontSize: 8,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12.v),
                    Align(
                      alignment: Alignment.center,
                      child: Divider(
                        indent: 24.h,
                        endIndent: 24.h,
                      ),
                    ),
                    SizedBox(height: 14.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "About the course".tr,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 11.v),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 325.h,
                        margin: EdgeInsets.symmetric(horizontal: 24.h),
                        child: Text(
                          provider.respo.data?.first.description ?? "",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "msg_about_instructor".tr,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h, right: 24.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 198, 229, 249),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.2 *
                                71.h), // 10% curve (0.1 times the width of the container)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: null !=
                                        provider.respo.data?.first
                                            .courseCreatorImage
                                    ? provider
                                        .respo.data?.first.courseCreatorImage
                                    : ImageConstant.imgRectangle9522,
                                height: 68.adaptSize,
                                width: 68.adaptSize,
                                radius: BorderRadius.circular(
                                  8.h,
                                ),
                                margin: EdgeInsets.only(bottom: 2.v),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 22.h,
                                  top: 2.v,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.respo.data?.first
                                              .courseCreator ??
                                          "",
                                      style: CustomTextStyles.titleMediumBold,
                                    ),
                                    SizedBox(height: 6.v),
                                    Text(
                                      provider.respo.data?.first
                                              .creatorDesignation ??
                                          "",
                                      style: CustomTextStyles
                                          .labelLargeManropeBluegray90002,
                                    ),
                                    SizedBox(height: 6.v),
                                    Text(
                                      "lbl_view_commentary".tr,
                                      style: CustomTextStyles
                                          .labelLargeManropeBluegray500
                                          .copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    provider.respo.data?.first.userEnrolled == true
                        ? SizedBox()
                        : entrolWidget(context),
                    SizedBox(height: 13.v),
                    _buildRowDay(context, provider),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "lbl_commentary".tr,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 325.h,
                        child: ReadMoreText(
                          provider.respo.data?.first.introCommentary ?? "",
                          trimLines: 8,
                          colorClickableText: appTheme.blueGray500,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "lbl_read_more".tr,
                          moreStyle: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.50,
                          ),
                          lessStyle: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Introductory Video".tr,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    CustomImageView(
                      imagePath: provider.respo.data?.first.introVideo != null
                          ? provider.respo.data?.first.introVideo
                          : ImageConstant.imgImage,
                      height: 200.v,
                      width: 326.h,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 8.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "${provider.respo.data?.first.courseName}",
                        style: CustomTextStyles.titleSmallBluegray90003,
                      ),
                    ),
                    SizedBox(height: 6.v),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Explaining ${provider.respo.data?.first.courseName}",
                        style: CustomTextStyles.bodySmallGray700,
                      ),
                    ),
                    SizedBox(height: 15.v),
                    _buildColumnAudio(context, provider),
                    SizedBox(height: 15.v),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  /// Section Widget
  Widget _buildColumnAudio(
      BuildContext context, StudyDetailsProvider provider) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 23.h, right: 23.h),
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Introductory  Audio".tr,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 8.v),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 198, 229, 249),
                borderRadius: BorderRadius.all(
                  Radius.circular(0.2 *
                      71.h), // 10% curve (0.1 times the width of the container)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${provider.respo.data?.first.courseName}",
                            style: CustomTextStyles
                                .labelLargeManropeBluegray9000313,
                          ),
                          SizedBox(height: 3.v),
                          Text(
                            "Commentary by ${provider.respo.data?.first.courseCreator}",
                            style: CustomTextStyles.bodySmallGray700,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: CustomIconButton(
                        height: 32.adaptSize,
                        width: 32.adaptSize,
                        onTap: () {
                          provider.playAudio();
                        },
                        padding: EdgeInsets.all(7.h),
                        decoration: IconButtonStyleHelper.fillGreenA,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgPlay,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackArrowLeft(
      BuildContext context, StudyDetailsProvider provider) {
    return SizedBox(
      height: 400.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            imagePath: null != provider.respo.data?.first.thumbnail
                ? provider.respo.data?.first.thumbnail
                : ImageConstant.imgRectangle625,
            height: 400.v,
            fit: BoxFit.cover,
            width: SizeUtils.width,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRowDayOne(BuildContext context, CourseContents model) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.h),
        padding: EdgeInsets.symmetric(
          horizontal: 11.h,
          vertical: 15.v,
        ),
        decoration: BoxDecoration(
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
                child: _buildColumngenesis(
                  context,
                  titleText: model.book ?? "",
                  chapterText: model.chapter ?? "",
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 3.adaptSize,
              width: 3.adaptSize,
              margin: EdgeInsets.only(bottom: 45.v),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(
                  1.h,
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgVector,
              height: 5.v,
              width: 10.h,
              margin: EdgeInsets.fromLTRB(7.h, 21.v, 12.h, 22.v),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowDay(BuildContext context, StudyDetailsProvider provider) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: provider.respo.data!.first.courseContents?.length ?? 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        CourseContents model =
            provider.respo.data!.first.courseContents![index];
        return GestureDetector(
            onTap: () {
              NavigatorService.pushNamed(AppRoutes.studyDayScreen,
                  arguments: model.dayId.toString());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildRowDayOne(context, model),
            ));
      },
    );
  }

  /// Section Widget
  Widget entrolWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.v),
        Padding(
          padding: EdgeInsets.only(left: 24.h, right: 24.h),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 170, 207, 231),
              borderRadius: BorderRadius.all(
                Radius.circular(0.12 *
                    71.h), // 10% curve (0.1 times the width of the container)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 22.h,
                      top: 2.v,
                    ),
                    child: Text(
                      "Enroll for March 31st Batch",
                      style: CustomTextStyles.titleSmallWhiteA700,
                    ),
                  )
                ],
              ),
            ),
          ),
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
          style: theme.textTheme.titleMedium!.copyWith(
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

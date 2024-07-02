import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            _buildStackArrowLeft(context),
            SizedBox(height: 7.v),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "msg_day_5_genesis_5_212".tr,
                          style: CustomTextStyles.titleLargeManrope,
                        ),
                      ),
                      SizedBox(height: 4.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.h,
                          right: 85.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.v),
                              child: Text(
                                "msg_genesis_old_testament".tr,
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
                              child: Text(
                                "lbl_50_chapters".tr,
                                style: CustomTextStyles.bodyMediumGray500,
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
                          "lbl_about_genesis".tr,
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
                            "msg_genesis_speaks_of".tr,
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
                      SizedBox(height: 29.v),
                      Padding(
                        padding: EdgeInsets.only(left: 42.h),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgRectangle9522,
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
                                    "msg_fr_joseph_vadakkan".tr,
                                    style: CustomTextStyles.titleMediumBold,
                                  ),
                                  SizedBox(height: 6.v),
                                  Text(
                                    "msg_the_archeparchy".tr,
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
                      SizedBox(height: 32.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "lbl_course".tr,
                          style: CustomTextStyles.titleMedium18,
                        ),
                      ),
                      SizedBox(height: 25.v),
                      _buildRowDay(context),
                      SizedBox(height: 29.v),
                      _buildRowDayOne(context),
                      SizedBox(height: 18.v),
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
                            "msg_this_is_the_account".tr,
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
                          "lbl_video".tr,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 8.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage,
                        height: 200.v,
                        width: 326.h,
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 8.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "msg_genesis_2_man".tr,
                          style: CustomTextStyles.titleSmallBluegray90003,
                        ),
                      ),
                      SizedBox(height: 6.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "msg_explaining_genesis".tr,
                          style: CustomTextStyles.bodySmallGray700,
                        ),
                      ),
                      SizedBox(height: 15.v),
                      _buildColumnAudio(context),
                      SizedBox(height: 22.v),
                      _buildColumnRelated(context),
                      SizedBox(height: 21.v),
                      _buildColumnAddNote(context),
                      SizedBox(height: 17.v),
                      _buildRowSpacerTwo(context),
                      SizedBox(height: 24.v),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "lbl_previous_notes".tr,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 13.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.h),
                        child: _buildRowEyeOne(
                          context,
                          monthText: "msg_audio_file_from".tr,
                        ),
                      ),
                      SizedBox(height: 11.v),
                      Align(
                        alignment: Alignment.center,
                        child: Divider(
                          color: appTheme.black900.withOpacity(0.08),
                          indent: 27.h,
                          endIndent: 24.h,
                        ),
                      ),
                      SizedBox(height: 8.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.h),
                        child: _buildRowEyeOne(
                          context,
                          monthText: "msg_text_file_from_24".tr,
                        ),
                      ),
                      SizedBox(height: 24.v),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "msg_mark_as_finished".tr,
                          style: CustomTextStyles.titleSmallWhiteA700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackArrowLeft(BuildContext context) {
    return SizedBox(
      height: 300.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle625,
            height: 300.v,
            width: 375.h,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowDay(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 35.h,
          right: 40.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "lbl_day".tr,
                      style: CustomTextStyles.bodyMediumGray100,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "lbl_01".tr,
                      style: CustomTextStyles.headlineSmallGray100,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.h),
              child: SizedBox(
                height: 49.v,
                child: VerticalDivider(
                  width: 1.h,
                  thickness: 1.v,
                  color: appTheme.whiteA700.withOpacity(0.2),
                  indent: 4.h,
                  endIndent: 7.h,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  bottom: 6.v,
                ),
                child: _buildColumngenesis(
                  context,
                  titleText: "lbl_genesis".tr,
                  chapterText: "lbl_chapter_1".tr,
                ),
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgCheckmark,
              height: 28.v,
              width: 29.h,
              margin: EdgeInsets.only(top: 22.v),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowDayOne(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.h),
        padding: EdgeInsets.symmetric(
          horizontal: 11.h,
          vertical: 15.v,
        ),
        decoration: AppDecoration.white.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      "lbl_day".tr,
                      style: CustomTextStyles.bodyMediumBluegray900,
                    ),
                  ),
                  Text(
                    "lbl_02".tr,
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
                  titleText: "lbl_genesis".tr,
                  chapterText: "lbl_chapter_2".tr,
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
  Widget _buildColumnAudio(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 23.h),
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_audio".tr,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 17.v),
            Padding(
              padding: EdgeInsets.only(
                left: 11.h,
                right: 37.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "msg_genesis_2_man".tr,
                          style:
                              CustomTextStyles.labelLargeManropeBluegray9000313,
                        ),
                        SizedBox(height: 3.v),
                        Text(
                          "msg_commentary_by_fr".tr,
                          style: CustomTextStyles.bodySmallGray700,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 41.h,
                      top: 3.v,
                      bottom: 6.v,
                    ),
                    child: CustomIconButton(
                      height: 28.adaptSize,
                      width: 28.adaptSize,
                      padding: EdgeInsets.all(7.h),
                      decoration: IconButtonStyleHelper.fillGreenA,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlay,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnRelated(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 23.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: Text(
                "msg_related_articles".tr,
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 5.v),
            SizedBox(
              height: 106.v,
              child: Consumer<StudyDetailsProvider>(
                builder: (context, provider, child) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 6.h,
                      );
                    },
                    itemCount: provider
                        .studyDetailsModelObj.studyDetailsItemList.length,
                    itemBuilder: (context, index) {
                      StudyDetailsItemModel model = provider
                          .studyDetailsModelObj.studyDetailsItemList[index];
                      return StudyDetailsItemWidget(
                        model,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnAddNote(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 23.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: Text(
                "lbl_add_note".tr,
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 7.v),
            Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: Selector<StudyDetailsProvider, TextEditingController?>(
                selector: (context, provider) => provider.typehereController,
                builder: (context, typehereController, child) {
                  return CustomTextFormField(
                    controller: typehereController,
                    hintText: "lbl_type_here".tr,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSpacerTwo(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 72.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {},
                            constraints: BoxConstraints(
                              minHeight: 30.adaptSize,
                              minWidth: 30.adaptSize,
                            ),
                            padding: EdgeInsets.all(0),
                            icon: SizedBox(
                              width: 30.adaptSize,
                              height: 30.adaptSize,
                              child: CustomImageView(
                                imagePath: ImageConstant.imageNotFound,
                              ),
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgIconMic,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                  ),
                  CustomIconButton(
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    padding: EdgeInsets.all(7.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgGroup44,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                top: 5.v,
                bottom: 4.v,
              ),
              child: Text(
                "lbl_post_note".tr,
                style: CustomTextStyles.titleSmallBluegray500,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: CustomIconButton(
                height: 30.adaptSize,
                width: 30.adaptSize,
                padding: EdgeInsets.all(7.h),
                decoration: IconButtonStyleHelper.fillGrayTL15,
                child: CustomImageView(
                  imagePath: ImageConstant.imgIconSend,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildColumngenesis(
    BuildContext context, {
    required String titleText,
    required String chapterText,
  }) {
    return Column(
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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/custom_icon_button.dart';
import 'models/course_detail_respo.dart';
import 'provider/study_details_provider.dart';

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
      print(course_id);
      Provider.of<StudyDetailsProvider>(context, listen: false)
          .getDetails(course_id);
    });
  }

  _changeStatusBarToLight() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyDetailsProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderWidget();
      }
      return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 270.0,
              leading: AppbarLeadingIconbutton(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(left: 1.h, right: 1.h),
                  onTap: () {
                    onTapArrowLeft(context);
                  }),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: _buildStackArrowLeft(context, provider),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24.h, top: 13),
                          child: SizedBox(
                            width: SizeUtils.width / 1.2,
                            child: AutoSizeText(
                              "${provider.respo.data?.first.courseName ?? ""} : ${provider.respo.data?.first.batchName ?? ""}",
                              style: CustomTextStyles.titleLargeManrope,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 22.h,
                            right: 24.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 0.v),
                                child: SizedBox(
                                  width: SizeUtils.width / 2.4,
                                  child: AutoSizeText(
                                    provider.respo.data?.first
                                                .courseStartStatus ==
                                            "started"
                                        ? " Started on : ${provider.respo.data?.first.startDate ?? ""}"
                                        : " Start on ${provider.respo.data?.first.startDate ?? ""}",
                                    style:
                                        CustomTextStyles.titleSmallBluegray500,
                                  ),
                                ),
                              ),
                              Container(
                                height: 4.adaptSize,
                                width: 4.adaptSize,
                                margin: EdgeInsets.only(
                                  left: 9.h,
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
                                  width: SizeUtils.width / 2.6,
                                  child: AutoSizeText(
                                    provider.respo.data?.first
                                                .courseStartStatus ==
                                            "started"
                                        ? "Last updated date : ${provider.respo.data?.first.lastUpdatedData ?? ""}"
                                        : "Enrolment Last date  ${provider.respo.data?.first.lastDate ?? ""}",
                                    style: CustomTextStyles.bodySmallGray700,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
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
                            style: CustomTextStyles.titleMediumSemiBold16,
                          ),
                        ),
                        SizedBox(height: 8.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.h),
                            child: Text(
                              provider.respo.data?.first.description ?? "",
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
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // 10-pixel edge radius
                                  child: CustomImageView(
                                    imagePath: ImageConstant.grayBack,
                                    fit: BoxFit
                                        .cover, // Ensures the image covers the entire container
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 9, bottom: 9),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: null !=
                                              provider.respo.data?.first
                                                  .creatorImage
                                          ? provider
                                              .respo.data?.first.creatorImage
                                          : ImageConstant.imgRectangle9522,
                                      height: 68.adaptSize,
                                      width: 68.adaptSize,
                                      fit: BoxFit.cover,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: SizeUtils.width / 1.8,
                                            child: AutoSizeText(
                                              provider.respo.data?.first
                                                      .courseCreator ??
                                                  "",
                                              maxLines: 1,
                                              style: CustomTextStyles
                                                  .titleMediumBold,
                                            ),
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
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        provider.respo.data?.first.userEnrolled == true
                            ? SizedBox()
                            : entrolWidget(context, provider),
                        SizedBox(height: 13.v),
                        provider.respo.data?.first.userEnrolled == true
                            ? _buildRowDay(context, provider)
                            : SizedBox(),
                        SizedBox(height: 8.v),
                        Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: Text(
                            "Introductory Video".tr,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 8.v),
                        provider.controller != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 24.h,
                                  right: 23.h,
                                ),
                                child: YoutubePlayer(
                                  controller: provider.controller!,
                                  bottomActions: [
                                    CurrentPosition(),
                                    ProgressBar(isExpanded: true)
                                  ],
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.amber,
                                  progressColors: const ProgressBarColors(
                                    playedColor: Colors.amber,
                                    handleColor: Colors.amberAccent,
                                  ),
                                  onReady: () {},
                                ),
                              )
                            : SizedBox(),

                        // Padding(
                        //     padding: EdgeInsets.only(
                        //       left: 2.h,
                        //       right: 2.h,
                        //     ),
                        //     child: SizedBox(
                        //       height: 200.v,
                        //       child: WebViewWidget(
                        //         controller: provider.controller,
                        //       ),
                        //     )),

                        // GestureDetector(
                        //   onTap: () {
                        //     NavigatorService.pushNamed(AppRoutes.videoPlayerScreen,
                        //         arguments: provider.respo.data?.first.introVideo
                        //             .toString());
                        //   },
                        //   child: CustomImageView(
                        //     imagePath: provider.respo.data?.first.introVideo != null
                        //         ? provider.respo.data?.first.introVideoThumb
                        //         : ImageConstant.imgImage,
                        //     height: 200.v,
                        //     width: 326.h,
                        //     fit: BoxFit.cover,
                        //     alignment: Alignment.center,
                        //   ),
                        // ),
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
                ],
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
            // Text(
            //   provider.connectionStatus,
            //   style: theme.textTheme.titleMedium,
            // ),
            SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                // Background Image with Rounded Corners
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10), // 10-pixel edge radius
                    child: CustomImageView(
                      imagePath: ImageConstant.spotif_back,
                      fit: BoxFit
                          .cover, // Ensures the image covers the entire container
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),

                // Overlay Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${provider.respo.data?.first.courseName ?? ''}",
                              style: CustomTextStyles
                                  .labelLargeManropeBluegray9000313,
                            ),
                            SizedBox(height: 3.v),
                            Text(
                              "Commentary by ${provider.respo.data?.first.courseCreator ?? ''}",
                              style: CustomTextStyles.bodySmallGray700,
                            ),
                          ],
                        ),
                      ),
                      provider.isPlaying
                          ? Padding(
                              padding: EdgeInsets.zero,
                              child: CustomIconButton(
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                onTap: () {
                                  provider.pauseAudio();
                                },
                                padding: EdgeInsets.all(6.h),
                                decoration: IconButtonStyleHelper.fillGreenA,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgPause,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.zero,
                              child: CustomIconButton(
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                onTap: () {
                                  provider.playAudio(
                                      provider.respo.data?.first.introAudio);
                                },
                                padding: EdgeInsets.all(6.h),
                                decoration: IconButtonStyleHelper.fillGreenA,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgPlay,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0, right: 28.0),
              child: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 5.0,
                animation: true,
                percent:
                    (provider.respo.data?.first.completionPercentage ?? 0) /
                        100,
                center: new Text(
                  "${provider.respo.data?.first.completionPercentage}%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
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
            color:
                model.readStatus == true ? appTheme.entrolColor : Colors.white,
            // color:  Color.fromARGB(255, 143, 187, 226),
            border: Border.all(
              width: 1,
              color: model.readStatus == true
                  ? appTheme.entrolColor
                  : Color.fromARGB(255, 143, 187, 226),
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
                      style: model.readStatus == true
                          ? CustomTextStyles.bodyMediumWhite
                          : CustomTextStyles.bodyMediumBluegray900,
                    ),
                  ),
                  Text(
                    model.day.toString(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                        color: model.readStatus == true
                            ? Colors.white
                            : appTheme.entrolColor),
                  ),
                  Text(
                    model.readStatus == true ? "COMPLETE" : "PENDING",
                    style: model.readStatus == true
                        ? CustomTextStyles.bodyMediumWhiteText
                        : CustomTextStyles.bodyMediumBluegray90010,
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
                                color: model.readStatus == true
                                    ? appTheme.whiteA700
                                    : appTheme.blueGray90002,
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
            model.readStatus == true
                ? CustomImageView(
                    imagePath: ImageConstant.tick_white,
                    height: 30.v,
                    width: 30.h,
                    margin: EdgeInsets.fromLTRB(7.h, 2.v, 12.h, 2.v),
                  )
                : CustomImageView(
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
  Widget _buildRowDay(BuildContext context, StudyDetailsProvider provider) {
    return provider.respo.data?.first.courseContent?.length != 0
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.h, right: 24.h),
                child: Row(
                  children: [
                    Text(
                      "Course".tr,
                      style: theme.textTheme.titleMedium,
                    ),
                    Spacer(),
                    SizedBox(
                      width: SizeUtils.width / 1.7,
                      child: Text(
                        "${provider.respo.data?.first.batchName ?? ""} | ${provider.respo.data?.first.startDate ?? ""}",
                        style: CustomTextStyles.titleSmallBluegray500,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:
                    provider.respo.data?.first.courseContent?.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  CourseContent model =
                      provider.respo.data!.first.courseContent![index];
                  return GestureDetector(
                      onTap: () {
                        provider.navigateToDetail(
                            model.courseContentId.toString(),
                            model.day.toString(),
                            provider.respo.data?.first.userLmsId.toString());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: _buildRowDayOne(context, model),
                      ));
                },
              ),
              provider.respo.data?.first.courseContent?.length != 0
                  ? GestureDetector(
                      onTap: () {
                        NavigatorService.pushNamed(AppRoutes.courseFullScreen,
                                arguments: provider.course_id)
                            .then((val) =>
                                provider.getDetails(provider.course_id));
                        ;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Show More",
                              style: CustomTextStyles.titleSmallBluegray500,
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.dropdownicon,
                            )
                          ],
                        ),
                      ))
                  : SizedBox()
            ],
          )
        : SizedBox();
  }

  /// Section Widget
  Widget entrolWidget(BuildContext context, StudyDetailsProvider provider) {
    return Column(
      children: [
        SizedBox(height: 16.v),
        Padding(
          padding: EdgeInsets.only(left: 24.h, right: 24.h),
          child: Container(
            decoration: BoxDecoration(
              color: appTheme.entrolColor,
              borderRadius: BorderRadius.all(
                Radius.circular(0.12 *
                    71.h), // 10% curve (0.1 times the width of the container)
              ),
            ),
            child: GestureDetector(
              onTap: () {
                provider.showEnrollAlert(context);
                // .then((val) => {
                //       if (val == true) {provider.getDetails(provider.course_id)}
                //     });
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enroll for ${provider.respo.data?.first.startDate} Batch",
                      style: CustomTextStyles.titleSmallWhiteA700,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

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

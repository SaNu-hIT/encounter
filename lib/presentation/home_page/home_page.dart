import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../core/app_export.dart';
import '../../core/utils/size_utils.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_search_view.dart';
import '../../widgets/loader_widget.dart';
import '../home_container_screen/provider/home_container_provider.dart';
import 'models/explorecommentary_item_model.dart';
import 'models/home_model.dart';
import 'models/home_respo.dart';
import 'models/viewhierarchy_item_model.dart';
import 'provider/home_provider.dart';
import 'widgets/explorecommentary_item_widget.dart';
import 'widgets/viewhierarchy_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  HomePageState createState() => HomePageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: HomePage(),
    );
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getHome("10");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return LoaderHomeWidget();
      }

      return Scaffold(
        backgroundColor: appTheme.gray10001,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 0.v),
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildTelevision(context, provider),
                  SizedBox(height: 18.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: CustomSearchView(
                      controller: provider.searchController,
                      hintText: "msg_search_books_chapters".tr,
                    ),
                  ),
                  SizedBox(height: 18.v),
                  _buildExploreCommentary(context),
                  SizedBox(height: 18.v),
                  _buildRowBibleStudy(context),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "msg_stay_rooted_in_god_s".tr,
                        style: CustomTextStyles.bodySmallGray90001,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.v),
                  _buildViewHierarchy(context),
                  SizedBox(height: 18.v),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 170.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.logoHome,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 5.v,
          bottom: 10.v,
        ),
      ),
      // title: Padding(
      //   padding: EdgeInsets.only(left: 10.h),
      //   child: Column(
      //     children: [
      //       AppbarSubtitleOne(
      //         text: "lbl_welcome".tr,
      //       ),
      //       AppbarTitle(
      //         text: "lbl_jeevan_george".tr,
      //       )
      //     ],
      //   ),
      // ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotification5,
          margin: EdgeInsets.fromLTRB(21.h, 13.v, 21.h, 12.v),
        )
      ],
    );
  }

  Widget _buildTelevision(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 368.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgRectangle4322,
                    //   width: 368.h,
                    //   radius: BorderRadius.circular(
                    //     10.h,
                    //   ),
                    //   alignment: Alignment.center,
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: 26.h,
                        //   vertical: 17.v,
                        // ),
                        width: 368.h,
                        decoration: AppDecoration.gradientBlackToBlack.copyWith(
                          borderRadius: BorderRadius.circular(
                            10.h,
                          ),
                          image: DecorationImage(
                            image: AssetImage(ImageConstant.imgRectangle4322),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                width: 312.h,
                                margin: EdgeInsets.only(right: 2.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Bible quote of the day",
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: CustomTextStyles
                                              .titleMediumSemiBold18,
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            shareToWhatsAppText(
                                                provider.respo.bibleVerse
                                                        ?.data1 ??
                                                    "",
                                                provider.respo.bibleVerse
                                                        ?.data2 ??
                                                    "",
                                                "");
                                          },
                                          child: CustomImageView(
                                            imagePath: ImageConstant.imgShare11,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SelectionArea(
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight:
                                              90.0, // Set the minimum height you want
                                        ),
                                        child: Center(
                                          child: HtmlWidget(
                                            provider.respo.bibleVerse?.data1 ??
                                                "",
                                            textStyle: CustomTextStyles
                                                .titleSmallPoppinsWhiteA70001,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    AutoSizeText(
                                      provider.respo.bibleVerse?.data2 ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: CustomTextStyles
                                          .titleSmallPoppinsWhiteA700012,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget bannerWithBibleWorse(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: SizedBox(
        height: 180.v,
        width: SizeUtils.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle4322,
              height: 180.v,
              width: SizeUtils.width,
              radius: BorderRadius.circular(
                10.h,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  right: 7.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgSend,
                      height: 24.v,
                      width: 24.h,
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: 41.v),
                    Text(
                      "msg_bible_quote_of_the".tr,
                      style: CustomTextStyles.labelManropeWhiteSemi20,
                    ),
                    SizedBox(height: 5.v),
                    Container(
                      width: 295.h,
                      margin: EdgeInsets.only(right: 9.h),
                      child: Text(
                        "msg_don_t_you_know_that".tr,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.labelManropeWhiteSemi18,
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
  Widget _buildExploreCommentary(BuildContext context) {
    return SizedBox(
      height: 110.v,
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: EdgeInsets.only(
              left: 20.h,
              right: 20.h,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: provider.homeModelObj.explorecommentaryItemList.length,
            itemBuilder: (context, index) {
              ExplorecommentaryItemModel model =
                  provider.homeModelObj.explorecommentaryItemList[index];
              return ExplorecommentaryItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRowBibleStudy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_bible_study".tr,
            style: CustomTextStyles.titleMediumGray90001,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<HomeContainerProvider>(context, listen: false)
                  .selectTab(BottomBarEnum.Study);
            },
            child: Text(
              "lbl_see_all".tr,
              style: CustomTextStyles.titleSmallBluegray600,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildViewHierarchy(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 220.v,
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return ListView.separated(
              padding: EdgeInsets.only(left: 12.h),
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 12.h,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: provider.respo.data?.first.list?.length ?? 0,
              itemBuilder: (context, index) {
                BibileList model = provider.respo.data!.first.list![index];
                return CourseListWidget(
                  model,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

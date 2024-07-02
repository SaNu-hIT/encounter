import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'models/explorecommentary_item_model.dart';
import 'models/home_model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray10001,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: SizeUtils.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 7.v),
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.v),
            child: Column(
              children: [
                bannerWithBibleWorse(context),
                SizedBox(height: 18.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Selector<HomeProvider, TextEditingController?>(
                    selector: (context, provider) => provider.searchController,
                    builder: (context, searchController, child) {
                      return CustomSearchView(
                        controller: searchController,
                        hintText: "msg_search_books_chapters".tr,
                      );
                    },
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
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
      height: 90,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMale,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 5.v,
          bottom: 10.v,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Column(
          children: [
            AppbarSubtitleOne(
              text: "lbl_welcome".tr,
            ),
            AppbarTitle(
              text: "lbl_jeevan_george".tr,
            )
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotification5,
          margin: EdgeInsets.fromLTRB(21.h, 13.v, 21.h, 12.v),
        )
      ],
    );
  }

  /// Section Widget
  Widget bannerWithBibleWorse(BuildContext context) {
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
          Text(
            "lbl_see_all".tr,
            style: CustomTextStyles.titleSmallBluegray600,
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
        height: 235.v,
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return ListView.separated(
              padding: EdgeInsets.only(left: 24.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 15.h,
                );
              },
              itemCount: provider.homeModelObj.viewhierarchyItemList.length,
              itemBuilder: (context, index) {
                ViewhierarchyItemModel model =
                    provider.homeModelObj.viewhierarchyItemList[index];
                return ViewhierarchyItemWidget(
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

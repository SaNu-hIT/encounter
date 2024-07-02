import 'package:encounter_app/localization/app_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_image_view.dart';
import 'models/bible_model.dart';
import 'provider/bible_provider.dart'; // ignore_for_file: must_be_immutable

class BiblePage extends StatefulWidget {
  const BiblePage({Key? key})
      : super(
          key: key,
        );

  @override
  BiblePageState createState() => BiblePageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BibleProvider(),
      child: BiblePage(),
    );
  }
}

class BiblePageState extends State<BiblePage>
    with AutomaticKeepAliveClientMixin<BiblePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray50,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 22.h,
                          right: 23.h,
                        ),
                        child: Selector<BibleProvider, BibleModel?>(
                          selector: (context, provider) =>
                              provider.bibleModelObj,
                          builder: (context, bibleModelObj, child) {
                            return CustomDropDown(
                              hintText: "lbl_genesis".tr,
                              items: bibleModelObj?.dropdownItemList ?? [],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 34.v),
                      _buildChaptersCounterRowFourteen(context),
                      SizedBox(height: 29.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 22.h),
                          child: Text(
                            "lbl_genesis_19".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      SizedBox(height: 9.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 22.h),
                          child: Text(
                            "msg_the_destruction".tr,
                            style: CustomTextStyles.titleSmallBluegray90002,
                          ),
                        ),
                      ),
                      SizedBox(height: 17.v),
                      Container(
                        width: 327.h,
                        margin: EdgeInsets.only(
                          left: 21.h,
                          right: 23.h,
                        ),
                        child: Text(
                          "msg_the_two_angels_arrived".tr,
                          maxLines: 21,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodyMedium13.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                      Text(
                        "lbl_show_more".tr,
                        style: CustomTextStyles.titleMediumBluegray500,
                      ),
                      SizedBox(height: 3.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgPolygon5,
                        height: 8.v,
                        width: 14.h,
                      ),
                      SizedBox(height: 27.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 22.h,
                          right: 23.h,
                        ),
                        child: Selector<BibleProvider, BibleModel?>(
                          selector: (context, provider) =>
                              provider.bibleModelObj,
                          builder: (context, bibleModelObj, child) {
                            return CustomDropDown(
                              hintText: "lbl_exodus".tr,
                              items: bibleModelObj?.dropdownItemList1 ?? [],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 22.h,
                          right: 23.h,
                        ),
                        child: Selector<BibleProvider, BibleModel?>(
                          selector: (context, provider) =>
                              provider.bibleModelObj,
                          builder: (context, bibleModelObj, child) {
                            return CustomDropDown(
                              hintText: "lbl_leviticus".tr,
                              items: bibleModelObj?.dropdownItemList2 ?? [],
                            );
                          },
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
    );
  }

  /// Section Widget
  Widget _buildChaptersCounterRowFourteen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "lbl_14".tr,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleSmall,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 21.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl_15".tr,
                  style: theme.textTheme.titleSmall,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: Text(
                    "lbl_16".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text(
                    "lbl_17".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text(
                    "lbl_18".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: Text(
                    "lbl_19".tr,
                    style: CustomTextStyles.titleSmallWhiteA700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_20".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_21".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 19.h),
                  child: Text(
                    "lbl_22".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: Text(
                    "lbl_23".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.h),
          child: Text(
            "lbl_24".tr,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}

import 'package:encounter_app/localization/app_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_one.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/appbar_trailing_switch.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../bible_page/bible_page.dart';
import 'models/bible_tab_container_model.dart';
import 'provider/bible_tab_container_provider.dart';

class BibleTabContainerScreen extends StatefulWidget {
  const BibleTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  BibleTabContainerScreenState createState() => BibleTabContainerScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BibleTabContainerProvider(),
      child: BibleTabContainerScreen(),
    );
  }
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BibleTabContainerScreenState extends State<BibleTabContainerScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray50,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 12.v),
            child: Column(
              children: [
                _buildTabview(context),
                SizedBox(
                  height: 908.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      BiblePage.builder(context),
                      BiblePage.builder(context)
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
      leading: AppbarLeadingIconbuttonOne(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 8.v,
          bottom: 8.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarSubtitle(
        text: "lbl_bible".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      actions: [
        Selector<BibleTabContainerProvider, bool?>(
          selector: (context, provider) => provider.isSelectedSwitch,
          builder: (context, isSelectedSwitch, child) {
            return AppbarTrailingSwitch(
              value: isSelectedSwitch ?? false,
              onTap: (value) {
                context
                    .read<BibleTabContainerProvider>()
                    .changeSwitchBox(value!);
              },
            );
          },
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgShare11,
          margin: EdgeInsets.fromLTRB(13.h, 18.v, 36.h, 1.v),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 54.v,
      width: 327.h,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(
          16.h,
        ),
      ),
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.blueGray700,
        unselectedLabelColor: appTheme.whiteA700,
        tabs: [
          Tab(
            child: Text(
              "lbl_old_testament".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_new_testament".tr,
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}

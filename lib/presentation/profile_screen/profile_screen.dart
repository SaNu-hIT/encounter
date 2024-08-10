import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_switch.dart';
import '../home_page/home_page.dart';
import 'models/profile_model.dart';
import 'provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ProfileScreenState createState() => ProfileScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: ProfileScreen(),
    );
  }
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray10001,
      appBar: _buildAppbar(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 23.h,
          vertical: 8.v,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColumnbiblequot(context),
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "msg_share_encounter".tr,
                  style: CustomTextStyles.bodyMediumBluegray70001,
                ),
              ),
              SizedBox(height: 8.v),
              _buildRowcopy(context),
              SizedBox(height: 26.v),
              Divider(
                indent: 1.h,
              ),
              SizedBox(height: 25.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: _buildRowclockOne(
                  context,
                  clockImage: ImageConstant.imgSettings,
                  logout: "lbl_edit_profile".tr,
                ),
              ),
              SizedBox(height: 30.v),
              _buildRowquestionsone(context),
              SizedBox(height: 30.v),
              _buildRowquestionsAsk(context),
              SizedBox(height: 31.v),
              _buildRownotesone(context),
              SizedBox(height: 27.v),
              _buildRowiconone(context),
              SizedBox(height: 29.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: _buildRowclockOne(
                  context,
                  clockImage: ImageConstant.imgClock,
                  logout: "lbl_logout".tr,
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
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
              margin: EdgeInsets.only(right: 67.h),
            ),
            AppbarTitle(
              text: "lbl_jeevan_george".tr,
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnbiblequot(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 31.h,
        vertical: 25.v,
      ),
      decoration: BoxDecoration(
        color: appTheme.blueGray600,
        borderRadius: BorderRadiusStyle.roundedBorder16,
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgGroup23,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.88,
            child: Text(
              "msg_bible_quote_of_the2".tr,
              style: CustomTextStyles.titleSmallYellow200a9,
            ),
          ),
          SizedBox(height: 15.v),
          Opacity(
            opacity: 0.88,
            child: SizedBox(
              width: 261.h,
              child: Text(
                "msg_therefore_each_of".tr,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.labelLargeManropeWhiteA700_1.copyWith(
                  height: 1.50,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowcopy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedButton(
            width: 200.h,
            text: "msg_play_store_encounterujexnpyc2".tr,
          ),
          CustomElevatedButton(
            width: 75.h,
            text: "lbl_copy".tr,
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgSettingsWhiteA700,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
            ),
            buttonStyle: CustomButtonStyles.fillAmber,
            buttonTextStyle: CustomTextStyles.labelLargeManropeWhiteA700,
          ),
          CustomIconButton(
            height: 40.v,
            width: 37.h,
    
            padding: EdgeInsets.all(9.h),
            decoration: IconButtonStyleHelper.fillGreen,
            child: CustomImageView(
              imagePath: ImageConstant.imgVolume,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowquestionsone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: GestureDetector(
        onTap: () => {
          NavigatorService.pushNamed(
            AppRoutes.got_questions,
          )
        },
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgQuestions1,
              height: 22.adaptSize,
              width: 22.adaptSize,
              color: appTheme.blueGray600,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.h),
              child: Text(
                "Got Questions".tr,
                style: CustomTextStyles.titleMediumGray70002,
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 20.adaptSize,
              width: 20.adaptSize,
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowquestionsAsk(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: GestureDetector(
        onTap: () => {
          NavigatorService.pushNamed(
            AppRoutes.ask_questions,
          )
        },
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgQuestions1,
              height: 22.adaptSize,
              width: 22.adaptSize,
              color: appTheme.blueGray600,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.h),
              child: Text(
                "lbl_ask_questions".tr,
                style: CustomTextStyles.titleMediumGray70002,
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 20.adaptSize,
              width: 20.adaptSize,
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRownotesone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgNotesTeal800,
            height: 20.adaptSize,
            width: 20.adaptSize,
            color: appTheme.blueGray600,
            margin: EdgeInsets.only(bottom: 3.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.h),
            child: Text(
              "lbl_my_notes".tr,
              style: CustomTextStyles.titleMediumGray70002,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(bottom: 3.v),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowiconone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconNotification,
            height: 24.adaptSize,
            width: 24.adaptSize,
            color: appTheme.blueGray600,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_notification".tr,
              style: CustomTextStyles.titleMediumGray70002,
            ),
          ),
          Spacer(),
          Selector<ProfileProvider, bool?>(
            selector: (context, provider) => provider.isSelectedSwitch,
            builder: (context, isSelectedSwitch, child) {
              return CustomSwitch(
                value: isSelectedSwitch,
                onChange: (value) {
                  context.read<ProfileProvider>().changeSwitchBox(value);
                },
              );
            },
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottombar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  /// Common widget
  Widget _buildRowclockOne(
    BuildContext context, {
    required String clockImage,
    required String logout,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomImageView(
          imagePath: clockImage,
          height: 24.adaptSize,
          width: 24.adaptSize,
          color: appTheme.blueGray600,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16.h,
            top: 3.v,
          ),
          child: Text(
            logout,
            style: CustomTextStyles.titleMediumGray70002.copyWith(
              color: appTheme.gray70002,
            ),
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRight,
          height: 20.adaptSize,
          width: 20.adaptSize,
          margin: EdgeInsets.only(top: 5.v),
        )
      ],
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Study:
        return "/";
      case BottomBarEnum.Bible:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage.builder(context);
      default:
        return DefaultWidget();
    }
  }
}

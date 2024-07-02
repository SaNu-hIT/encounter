import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/onboarding_model.dart';

/// A provider class for the OnboardingScreen.
///
/// This provider manages the state of the OnboardingScreen, including the
/// current onboardingModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class OnboardingProvider extends ChangeNotifier {
  OnboardingModel onboardingModelObj = OnboardingModel();
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true, initialPage: 0);
  int currentPageIndex = 0;
  String buttonText = "Next";

  void onPageChanged(int index) {
    currentPageIndex = index;
    controller.jumpToPage(index);
    notifyListeners();
  }

  leftswipe() {
    if (currentPageIndex > 0) {
      onPageChanged(currentPageIndex - 1);
      buttonText = "Next";
    }

    notifyListeners();
  }

  rightswipe(BuildContext context) {
    if (currentPageIndex < welcomeList.length - 1) {
      onPageChanged(currentPageIndex + 1);
      if (currentPageIndex == welcomeList.length - 1) {
        buttonText = "Get Started";
      } else {
        buttonText = "Next";
      }
    }
    notifyListeners();
  }

  final List<Map> welcomeList = [
    {
      "titleFontSize": 28.0,
      "subTitleFontsize": 24.0,
      "image": ImageConstant.onboarding3,
      "title": "Lorem ipsum dolor sit amet",
      "subtitle":
          "There are many variations of passages of Lorem Ipsum available",
      "buttion": "NEXT"
    },
    {
      "titleFontSize": 30.0,
      "subTitleFontsize": 24.0,
      "image": ImageConstant.onboarding1,
      "title": "Lorem ipsum dolor sit amet",
      "subtitle":
          "There are many variations of passages of Lorem Ipsum available",
      "buttion": "NEXT"
    },
    {
      "titleFontSize": 24.0,
      "subTitleFontsize": 30.0,
      "image": ImageConstant.onboarding2,
      "title": "Lorem ipsum dolor sit amet",
      "subtitle":
          "There are many variations of passages of Lorem Ipsum available",
      "buttion": "Get Started"
    },
  ];

  void navigate(BuildContext context) {
    // SharedPrefs.setbool(SharedPrefKey.isOnBoardingCompleted, true);
    NavigatorService.popAndPushNamed(
      AppRoutes.loginScreen,
    );

  }
}

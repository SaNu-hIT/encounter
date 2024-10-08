import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../models/home_container_model.dart';

/// A provider class for the HomeContainerScreen.
///
/// This provider manages the state of the HomeContainerScreen, including the
/// current homeContainerModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomeContainerProvider extends ChangeNotifier {
  HomeContainerModel homeContainerModelObj = HomeContainerModel();
  BottomBarEnum _currentTab = BottomBarEnum.Home;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  BottomBarEnum get currentTab => _currentTab;

  void selectTab(BottomBarEnum tab) {
    _currentTab = tab;
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(getCurrentRoute(tab), (route) => false);
    notifyListeners();
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Study:
        return AppRoutes.studyDetailsScreen;
      case BottomBarEnum.Bible:
        return AppRoutes.biblePage;
      case BottomBarEnum.Profile:
        return AppRoutes.profileScreen;
      default:
        return "/";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

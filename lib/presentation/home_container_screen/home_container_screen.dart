import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../bible_page/bible_page.dart';
import '../home_page/home_page.dart';
import '../profile_screen/profile_screen.dart';
import '../study_details_screen/study_details_screen.dart';
import 'provider/home_container_provider.dart';

class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  HomeContainerScreenState createState() => HomeContainerScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeContainerProvider(),
      child: HomeContainerScreen(),
    );
  }
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomeContainerScreenState extends State<HomeContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray10001,
      body: Navigator(
        key: navigatorKey,
        initialRoute: AppRoutes.homePage,
        onGenerateRoute: (routeSetting) => PageRouteBuilder(
          pageBuilder: (ctx, ani, ani1) =>
              getCurrentPage(context, routeSetting.name!),
          transitionDuration: Duration(seconds: 0),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
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

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage.builder(context);
      case AppRoutes.studyDetailsScreen:
        return StudyDetailsScreen.builder(context);
      case AppRoutes.biblePage:
        return BiblePage.builder(context);
      case AppRoutes.profileScreen:
        return ProfileScreen.builder(context);
      default:
        return DefaultWidget();
    }
  }
}

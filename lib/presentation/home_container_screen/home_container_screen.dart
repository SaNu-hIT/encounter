import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../bible_page/bible_page.dart';
import '../home_page/home_page.dart';
import '../profile_screen/profile_screen.dart';
import '../study_details_screen/study_details_screen.dart';
import '../study_home/study_home.dart';
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

class HomeContainerScreenState extends State<HomeContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray10001,
      body: Consumer<HomeContainerProvider>(
        builder: (context, provider, child) {
          return Navigator(
            key: provider.navigatorKey,
            initialRoute: provider.getCurrentRoute(provider.currentTab),
            onGenerateRoute: (routeSetting) => PageRouteBuilder(
              pageBuilder: (ctx, ani, ani1) =>
                  getCurrentPage(context, routeSetting.name!),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Consumer<HomeContainerProvider>(
      builder: (context, provider, child) {
        return CustomBottomBar(
          currentIndex: provider.currentTab.index,
          onChanged: (BottomBarEnum type) {
            provider.selectTab(type);
          },
        );
      },
    );
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
        return StudyHomePage.builder(context);
      case AppRoutes.biblePage:
        return BiblePage.builder(context);
      case AppRoutes.profileScreen:
        return ProfileScreen.builder(context);
      default:
        return DefaultWidget();
    }
  }
}

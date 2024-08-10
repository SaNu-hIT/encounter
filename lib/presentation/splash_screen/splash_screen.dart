import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_name_header_widget.dart';
import 'models/splash_model.dart';
import 'provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  SplashScreenState createState() => SplashScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider(),
      child: SplashScreen(),
    );
  }
}

class SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(milliseconds: 3000), () {
  //     NavigatorService.popAndPushNamed(
  //       AppRoutes.onboardingScreen,
  //     );
  //   });

  // }

  @override
  void initState() {
    super.initState();
    initializeNavigation();
  }

  void initializeNavigation() async {
    String token = await PrefUtils().getToken();
    print("token: $token");
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (token != null && token.isNotEmpty) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeContainerScreen);
      } else {
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.loginScreen,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomImageView(
            width: SizeUtils.width,
            height: SizeUtils.height,
            fit: BoxFit.cover,
            imagePath: ImageConstant.imgSplash,
          ),
          Container(
            width: SizeUtils.width,
            height: SizeUtils.height,
            // decoration: BoxDecoration(
            //   color: appTheme.whiteA700,
            //   image: DecorationImage(
            //     image: AssetImage(
            //       ImageConstant.imgSplash,
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Container(
              padding: EdgeInsets.only(top: 132.v),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 21.v),
                  AppNameHeader(),
                  SizedBox(height: 5.v)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/app_export.dart';
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
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.onboardingScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: SizeUtils.width,
        height: SizeUtils.height,
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgSplash,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 132.v),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgG6554,
                height: 148.v,
                width: 107.h,
              ),
              SizedBox(height: 21.v),
              SizedBox(
                width: 160.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl_encounter".tr,
                        style: CustomTextStyles.displaySmallCanelaTrial,
                      ),
                      TextSpan(
                        text: "lbl_study_bible".tr,
                        style: CustomTextStyles
                            .headlineSmallCanelaTrialBluegray90001,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }
}

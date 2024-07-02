import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_elevated_button1.dart';
import 'models/onboarding_model.dart';
import 'provider/onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(),
      child: OnboardingScreen(),
    );
  }
}

class OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>(
        create: (context) => OnboardingProvider(),
        builder: (context, child) {
          final provider = Provider.of<OnboardingProvider>(context);
          final currentIndex = provider.currentPageIndex;

          return Scaffold(
              key: const Key("onboard"),
              body: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dx < 5) {
                      provider.rightswipe(context);
                    } else {
                      provider.leftswipe();
                    }
                  },
                  child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      padEnds: false,
                      // clipBehavior: Clip.,
                      controller: provider.controller,
                      onPageChanged: (value) {
                        provider.onPageChanged(value);
                      },
                      children: List.generate(
                          provider.welcomeList.length,
                          (index) => SingleChildScrollView(
                                  child: Stack(children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: //

                                      Container(
                                    // height: displayHeight(context) * .5,
                                    padding: EdgeInsets.only(
                                        left: 30,
                                        top: 35,
                                        right: 30,
                                        bottom: 30.v),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "assets/Background.png",
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(59),
                                          topRight: Radius.circular(59)),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 18.v),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                child: Container(
                                                  height: 6.v,
                                                  width: 311.h,
                                                  decoration: BoxDecoration(
                                                    color: appTheme.gray10002,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      3.h,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      3.h,
                                                    ),
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: 0.33,
                                                      backgroundColor:
                                                          appTheme.gray10002,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        appTheme.amber400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 31.v),
                                              SizedBox(height: 52.v),
                                              Consumer<OnboardingProvider>(
                                                  builder: (context, provider,
                                                      child) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 229.h,
                                                      child: Text(
                                                        provider.welcomeList[
                                                                currentIndex]
                                                            ["title"],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme.textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                          height: 1.21,
                                                        ),
                                                      ),
                                                    ),
                                                    CustomImageView(
                                                      imagePath:
                                                          provider.welcomeList[
                                                                  currentIndex]
                                                              ["image"],
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                    ),
                                                    SizedBox(height: 28.v),
                                                    _buildColumnDescription(
                                                        context,
                                                        provider,
                                                        currentIndex)
                                                  ],
                                                );
                                              }),
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                              ]))))));
        });
  }

  
  /// Section Widget
  Widget _buildColumnDescription(
      BuildContext context, OnboardingProvider provider, int currentIndex) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 38.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 19.v),
          Container(
            width: 282.h,
            margin: EdgeInsets.only(
              left: 8.h,
              right: 12.h,
            ),
            child: Text(
              provider.welcomeList[currentIndex]["subtitle"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 27.v),
          CustomElevatedButton1(
            height: 54.v,
            text: provider.welcomeList[currentIndex]["buttion"],
            onPressed: () => {
              if (currentIndex != 2)
                {provider.rightswipe(context)}
              else
                {provider.navigate(context)}
            },
            buttonStyle: CustomButtonStyles.outlineBlueGrayC,
            buttonTextStyle: CustomTextStyles.labelLargeManropeWhiteA700,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_name_header_widget.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_elevated_button1.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import 'provider/verify_email_provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key})
      : super(
          key: key,
        );

  @override
  VerifyEmailScreenState createState() => VerifyEmailScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VerifyEmailProvider(),
      child: VerifyEmailScreen(),
    );
  }
}

class VerifyEmailScreenState extends State<VerifyEmailScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: SizeUtils.width,
        height: SizeUtils.height,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgLoginRegister,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppNameHeader(),
                    SizedBox(height: 19.v),
                    _buildLoginRegisterSection(context),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginRegisterSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 29.h,
        vertical: 50.v,
      ),
      decoration: AppDecoration.gradientTealToTeal300.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_greetings_from".tr,
            style: CustomTextStyles.labelLargeManropeWhiteTitle,
          ),
          SizedBox(height: 3.v),
          Text(
            "lbl_encounter_app".tr,
            style: CustomTextStyles.labelLargeManropeWhiteHeading,
          ),
          SizedBox(height: 8.v),
          Text(
            'Please enter OTP received on your mobile number '.tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.labelLargeManropeWhiteSmall,
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              right: 10.h,
            ),
            child: Selector<VerifyEmailProvider, TextEditingController?>(
              selector: (
                context,
                provider,
              ) =>
                  provider.otpController,
              builder: (context, otpController, child) {
                return CustomPinCodeTextField(
                  context: context,
                  controller: otpController,
                  onChanged: (value) {
                    otpController?.text = value;
                  },
                );
              },
            ),
          ),
          SizedBox(height: 15.v),
          CustomElevatedButton1(
            text: "Submit",
            onPressed: () {
              NavigatorService.pushNamed(
                AppRoutes.homeContainerScreen,
              );
            },
            buttonStyle: CustomButtonStyles.outlineBlueGrayC,
          ),
          SizedBox(height: 24.v),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "msg_didn_t_recieve_otp2".tr,
                  style: theme.textTheme.bodyMedium,
                ),
                TextSpan(
                  text: "lbl_resend".tr,
                  style: CustomTextStyles.bodyMediumAmber300,
                )
              ],
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}

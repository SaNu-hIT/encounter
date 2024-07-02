import 'package:encounter_app/widgets/custom_text_form_field.dart';
import 'package:encounter_app/widgets/custom_text_form_field_login.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_name_header_widget.dart';
import '../../widgets/custom_elevated_button1.dart';
import '../../widgets/greating_widget.dart';
import 'provider/login_register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key})
      : super(
          key: key,
        );

  @override
  LoginRegisterScreenState createState() => LoginRegisterScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginRegisterProvider(),
      child: RegisterScreen(),
    );
  }
}

class LoginRegisterScreenState extends State<RegisterScreen> {
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
                    SizedBox(height: 12.v),
                    _buildLoginRegisterSection(context),
                    SizedBox(height: 12.v),
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
          GreatingWidget(),
          Text(
            "msg_please_enter_your".tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.labelLargeManropeWhiteSmall,
          ),
          SizedBox(height: 15.v),
          CustomTextFormFieldLogIn(
            fieldType: FieldType.name,
            hintText: "Name",
          ),
          SizedBox(height: 15.v),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(
                  color: Colors.white), // Change label text color to white
              hintStyle: TextStyle(
                  color: Colors.white), // Change hint text color to white
              prefixStyle: TextStyle(color: Colors.white),
              counterStyle: TextStyle(color: Colors.white),
              prefixIconColor: Colors.white,
              suffixIconColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(20),
              fillColor: appTheme.blueGray600, // Gray background
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove border
                borderRadius:
                    BorderRadius.all(Radius.circular(10)), // Rounded corners
              ),
            ),
            initialCountryCode: 'IN',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            style: TextStyle(
                color: Colors.white), // Change input text color to white
          ),
          SizedBox(height: 1.v),
          CustomTextFormFieldLogIn(
            fieldType: FieldType.email,
            hintText: "Email",
          ),
          SizedBox(height: 15.v),
          Row(
            children: [
              SizedBox(
                width: SizeUtils.width - 200,
                child: Text(
                  'By clicking register, you are agreeing to our terms and conditions',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: CustomTextStyles.labelLargeManropeWhiteSmall14,
                ),
              ),
              Spacer()
            ],
          ),
          SizedBox(height: 15.v),
          CustomElevatedButton1(
            text: "Register",
            onPressed: () {
              NavigatorService.pushNamed(
                AppRoutes.verifyEmailScreen,
              );
            },
            buttonStyle: CustomButtonStyles.outlineBlueGrayC,
          ),
          SizedBox(height: 15.v),
          GestureDetector(
            onTap: () {
              NavigatorService.popAndPushNamed(
                AppRoutes.loginScreen,
              );
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account ? ",
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: " ",
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: "LogIn",
                    style: CustomTextStyles.bodyMediumAmber300,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}

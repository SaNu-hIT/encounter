import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../services/secure_storage.dart';
import '../../../utils/enumeration.dart';
import '../../../utils/pref_utils.dart';
import '../../login_register_screen/models/login_model.dart';
import '../models/verify_email_model.dart';
import '../repo/verify_repo.dart';

/// A provider class for the VerifyEmailScreen.
///
/// This provider manages the state of the VerifyEmailScreen, including the
/// current verifyEmailModelObj
class VerifyEmailProvider extends ChangeNotifier {
  TextEditingController otpController = TextEditingController();
  final VerifyRepo _repo = VerifyRepo();
  VerifyModel verifyEmailModelObj = VerifyModel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }


  login(BuildContext context) async {
        var email = PrefUtils().getEmail();
    if (email != "") {
      loader(true);
      LoginModel loginRepo = await _repo.login(email: email);
      loader(false);
      if (loginRepo.status == "success") {
        PrefUtils().setEmail(email);
          Fluttertoast.showToast(
            msg: "OTP send success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "OTP Sending Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        loader(false);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter email and Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


  verifyEmail(BuildContext context) async {
    var email = PrefUtils().getEmail();
    if (otpController.text != "" && email != "") {
      loader(true);
      VerifyModel respo =
          await _repo.verify(email: email, otp: otpController.text);
      loader(false);
      if (respo.status == "success") {
        if (null != respo.data?.token) {
          SecureStorage.setValue(
              key: SecureStorageKeys.kAccessToken, value: respo.data?.token);
          PrefUtils().setToken(respo.data?.token ?? "");
          PrefUtils().setName(respo.data?.user?.firstName ?? "");
          PrefUtils().setEmail(respo.data?.user?.email ?? "");
          NavigatorService.pushNamed(
            AppRoutes.homeContainerScreen,
          );
        }
      } else {
        Fluttertoast.showToast(
            msg: "Invalid OTP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        loader(false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../services/secure_storage.dart';
import '../../../utils/enumeration.dart';
import '../../../utils/pref_utils.dart';
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

  verifyEmail(BuildContext context) async {
    var email = PrefUtils().getEmail();
    var familyCode = PrefUtils().getfamilyode();
    if (otpController.text != "" && email != "" && familyCode != "") {
      loader(true);
      VerifyModel respo = await _repo.verify(
          email: email, otp: otpController.text, familyCode: familyCode);
      loader(false);
      if (respo.status == "success") {
        if (null != respo.data?.token) {
          SecureStorage.setValue(
              key: SecureStorageKeys.kAccessToken, value: respo.data?.token);
          PrefUtils().setToken(respo.data?.token ?? "");
          PrefUtils().setName(respo.data?.user?.name ?? "");
          PrefUtils().setEmail(respo.data?.user?.email ?? "");
          PrefUtils().setfamilyName(respo.data?.user?.familyName ?? "");
          PrefUtils().setfamilyHeadName(respo.data?.user?.familyHeadName ?? "");
          PrefUtils().setImage(respo.data?.user?.image ?? "");
          PrefUtils().setUserType(respo.data?.user?.userType ?? "");
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

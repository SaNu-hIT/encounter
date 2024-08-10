import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../utils/pref_utils.dart';
import '../models/login_model.dart';
import '../repo/login_repo.dart';

/// A provider class for the LoginRegisterScreen.
///
/// This provider manages the state of the LoginRegisterScreen, including the
/// current loginRegisterModelObj
// ignore_for_file: must_be_immutable

class LoginRegisterProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  LoginModel loginModelObj = LoginModel();
  final LoginRepo _repo = LoginRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  login(BuildContext context) async {
    if (emailController.text != "") {
      loader(true);
      LoginModel loginRepo = await _repo.login(email: emailController.text);
      loader(false);
      if (loginRepo.status == "success") {
        PrefUtils().setEmail(emailController.text);
        NavigatorService.pushNamed(
          AppRoutes.verifyEmailScreen,
        );
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
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

  register(BuildContext context) async {
    if (emailController.text != "" && nameController.text != "") {
      loader(true);
      LoginModel loginRepo = await _repo.register(
          email: emailController.text,
          gender: "MALE",
          first_name: nameController.text);
      loader(false);
      if (loginRepo.status == "success") {
        PrefUtils().setEmail(emailController.text);
        // NavigatorService.pushNamed(
        //   AppRoutes.verifyEmailScreen,
        // );
        login(context);
      } else {
        Fluttertoast.showToast(
            msg: loginRepo.data?.messsage ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
}

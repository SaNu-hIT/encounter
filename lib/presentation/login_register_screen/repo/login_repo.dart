import 'dart:convert';

import '../../../../services/dio_services/dio_builder.dart';
import '../../../network/app_apis.dart';
import '../models/login_model.dart';

class LoginRepo {
  Future<LoginModel> login({required String email}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: false);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.login,
        options: dioBuilderResponse.dioOptions,
        data: jsonEncode(<String, String>{'email': email}),
      ));

      LoginModel registrationDetailsModel = LoginModel();
      if (response.statusCode == 200) {
        registrationDetailsModel = LoginModel.fromJson((response.data));
      } else {
        registrationDetailsModel = LoginModel.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return LoginModel();
    }
  }

  Future<LoginModel> register(
      {required String email,
      required String gender,
      required String first_name}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: false);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.signup,
        options: dioBuilderResponse.dioOptions,
        data: jsonEncode(<String, String>{
          'email': email,
          "first_name": first_name,
          "gender": gender
        }),
      ));

      LoginModel registrationDetailsModel = LoginModel();
      if (response.statusCode == 200) {
        registrationDetailsModel = LoginModel.fromJson((response.data));
      } else {
        registrationDetailsModel = LoginModel.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return LoginModel();
    }
  }
}

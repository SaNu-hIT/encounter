import 'dart:convert';


import '../../../../services/dio_services/dio_builder.dart';
import '../../../network/app_apis.dart';
import '../models/verify_email_model.dart';

class VerifyRepo {
  Future<VerifyModel> verify(
      {required String email,
      required String otp,
      required String familyCode}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: false);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.verify,
        options: dioBuilderResponse.dioOptions,
        data: jsonEncode(<String, String>{
          'email': email,
          'otp': otp,
          'family_code': familyCode
        }),
      ));

      VerifyModel registrationDetailsModel = VerifyModel();
      if (response.statusCode == 200) {
        registrationDetailsModel = VerifyModel.fromJson((response.data));
      } else {
        registrationDetailsModel = VerifyModel.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return VerifyModel();
    }
  }
}

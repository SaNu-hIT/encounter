import 'dart:convert';

import '../../../../services/dio_services/dio_builder.dart';
import '../../../network/app_apis.dart';
import '../models/bible_model.dart';

class BibleRepo {
  Future<BibleListModel> getBibleList({required String testament_id}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.bible_study,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'testament_id': testament_id,
        },
      ));

      BibleListModel registrationDetailsModel = BibleListModel();
      if (response.statusCode == 200) {
        registrationDetailsModel = BibleListModel.fromJson((response.data));
      } else {
        registrationDetailsModel = BibleListModel.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return BibleListModel();
    }
  }
}

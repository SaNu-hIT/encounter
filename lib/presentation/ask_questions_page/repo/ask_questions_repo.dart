import 'dart:convert';

import '../../../../services/dio_services/dio_builder.dart';
import '../../../network/app_apis.dart';
import '../models/ask_question_respo.dart';
import '../models/category_dropdown.dart';
import '../models/got_question_model.dart';

class AskQuestionsRepo {
  Future<GotQuestionModel> getQuestions(
      {required String search_word,
      required String gq_category,
      required String gq_subcategory}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.got_questions,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'search_word': search_word,
          'gq_category': gq_category,
          'gq_subcategory': gq_subcategory,
        },
      ));

      GotQuestionModel registrationDetailsModel = GotQuestionModel();
      if (response.statusCode == 200) {
        registrationDetailsModel = GotQuestionModel.fromJson((response.data));
      } else {
        registrationDetailsModel = GotQuestionModel.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return GotQuestionModel();
    }
  }

  Future<GotQuestionModel> askQuestions(
      {required String search_word,
      required String gq_category,
      required String gq_subcategory}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.asked_questions,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'search_word': search_word,
          'gq_category': gq_category,
          'gq_subcategory': gq_subcategory,
        },
      ));

      GotQuestionModel registrationDetailsModel = GotQuestionModel();
      if (response.statusCode == 200) {
        registrationDetailsModel = GotQuestionModel.fromJson((response.data));
      } else {
        registrationDetailsModel = GotQuestionModel.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return GotQuestionModel();
    }
  }

  Future<CategoryDropDown> getCategory() async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.got_question_categories,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {},
      ));

      CategoryDropDown registrationDetailsModel = CategoryDropDown();
      if (response.statusCode == 200) {
        registrationDetailsModel = CategoryDropDown.fromJson((response.data));
      } else {
        registrationDetailsModel = CategoryDropDown.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return CategoryDropDown();
    }
  }

  Future<AskQuestionRespo> askQuestion({required String question}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.ask_a_question,
        options: dioBuilderResponse.dioOptions,
        data: jsonEncode(<String, String>{
          'question': question,
        }),
      ));
      AskQuestionRespo registrationDetailsModel = AskQuestionRespo();
      if (response.statusCode == 200) {
        registrationDetailsModel = AskQuestionRespo.fromJson((response.data));
      } else {
        registrationDetailsModel = AskQuestionRespo.fromJson((response.data));
      }
      return registrationDetailsModel;
    } catch (e) {
      return AskQuestionRespo();
    }
  }
}

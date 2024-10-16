import 'package:encounter_app/presentation/study_details_screen/models/enroll_respo.dart';

import '../../../../services/dio_services/dio_builder.dart';
import '../../../network/app_apis.dart';
import '../models/common_respo.dart';
import '../models/course_day_details.dart';
import '../models/course_detail_respo.dart';
import '../models/tags_respo.dart';

class CourseDetailRepo {
  Future<EnrollResponse> enrollCourse({
    required String batch_id,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.enroll_batch,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'batch_id': batch_id,
        },
      ));

      EnrollResponse model = EnrollResponse();
      if (response.statusCode == 200) {
        model = EnrollResponse.fromJson((response.data));
      } else {
        model = EnrollResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return EnrollResponse();
    }
  }

  Future<CourseDetailRespo> getCourseDetail({
    required String course_id,
  }) async {
    print("getCourseDetail");
    print(course_id);
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.course_details,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'batch_id': course_id,
          'type': 1,
        },
      ));

      CourseDetailRespo model = CourseDetailRespo();
      if (response.statusCode == 200) {
        model = CourseDetailRespo.fromJson((response.data));
      } else {
        model = CourseDetailRespo.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return CourseDetailRespo();
    }
  }

  Future<CourseDetailRespo> getFullCourse({
    required String course_id,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.course_details,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'batch_id': course_id,
          'type': 2,
        },
      ));

      CourseDetailRespo model = CourseDetailRespo();
      if (response.statusCode == 200) {
        model = CourseDetailRespo.fromJson((response.data));
      } else {
        model = CourseDetailRespo.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return CourseDetailRespo();
    }
  }

  Future<CommonResponse> markAsComplete({
    required String user_lms_id,
    required String day,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.mark_as_read,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'user_lms_id': user_lms_id,
          'day': day,
        },
      ));

      CommonResponse model = CommonResponse();
      if (response.statusCode == 200) {
        model = CommonResponse.fromJson((response.data));
      } else {
        model = CommonResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return CommonResponse();
    }
  }

  Future<CourseDayDetailRespo> getCourseDayDetail({
    required String day_id,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.course_day_content,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'course_content_id': day_id,
        },
      ));

      CourseDayDetailRespo model = CourseDayDetailRespo();
      if (response.statusCode == 200) {
        model = CourseDayDetailRespo.fromJson((response.data));
      } else {
        model = CourseDayDetailRespo.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return CourseDayDetailRespo();
    }
  }

//  testament_id: verses?.testament,
//           book_id: verses?.book,
//           chapter_id: verses?.chapter,
//           verse_id: statements?.statementNo,
//           note: noteController.text
  Future<EnrollResponse> addNotes({
    required String testament_id,
    required String book_id,
    required String chapter_id,
    required String verse_id,
    required String note,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.enroll_batch,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'testament_id': testament_id,
          'book_id': book_id,
          'chapter_id': chapter_id,
          'verse_id': verse_id,
          'note': note,
        },
      ));

      EnrollResponse model = EnrollResponse();
      if (response.statusCode == 200) {
        model = EnrollResponse.fromJson((response.data));
      } else {
        model = EnrollResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return EnrollResponse();
    }
  }

  Future<EnrollResponse> addMarkings(
      {required type,
      required String statement_ids,
      required String data}) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.add_bible_markings,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'type': type,
          'statement_ids': statement_ids,
          'data': data,
        },
      ));

      EnrollResponse model = EnrollResponse();
      if (response.statusCode == 200) {
        model = EnrollResponse.fromJson((response.data));
      } else {
        model = EnrollResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return EnrollResponse();
    }
  }

  Future<EnrollResponse> addTags({
    required tagname,
  }) async {
    print(tagname);
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.post(
        AppAPIs.add_tags,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'tag_name': tagname,
        },
      ));

      EnrollResponse model = EnrollResponse();
      if (response.statusCode == 200) {
        model = EnrollResponse.fromJson((response.data));
      } else {
        model = EnrollResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return EnrollResponse();
    }
  }

  Future<EnrollResponse> deleteTags({
    required tagId,
  }) async {
    print(tagId);
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.delete(
        AppAPIs.delete_tag,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'id': tagId,
        },
      ));

      print(response.toString());
      EnrollResponse model = EnrollResponse();
      if (response.statusCode == 200) {
        model = EnrollResponse.fromJson((response.data));
      } else {
        model = EnrollResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return EnrollResponse();
    }
  }

  Future<TagsRespo> getTags() async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.my_tags,
        options: dioBuilderResponse.dioOptions,
      ));

      TagsRespo model = TagsRespo();
      if (response.statusCode == 200) {
        model = TagsRespo.fromJson((response.data));
      } else {
        model = TagsRespo.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return TagsRespo();
    }
  }
}

import '../../../services/dio_services/dio_builder.dart';
import '../../network/app_apis.dart';
import 'models/course_day_details.dart';
import 'models/course_detail_respo.dart';

class CourseDetailRepo {
  Future<CourseDetailRespo> getCourseDetail({
    required String course_id,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.course_details,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'id': course_id,
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
      return CourseDetailRespo();
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
          'course_id': day_id,
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
      return CourseDayDetailRespo();
    }
  }
}

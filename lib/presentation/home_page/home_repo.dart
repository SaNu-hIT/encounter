import '../../../services/dio_services/dio_builder.dart';
import '../../network/app_apis.dart';
import 'models/home_respo.dart';

class HomeRepo {
  Future<HomeRespo> getHome({
    required String length,
  }) async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.home,
        options: dioBuilderResponse.dioOptions,
        queryParameters: {
          'length': length,
        },
      ));

      HomeRespo model = HomeRespo();
      if (response.statusCode == 200) {
        model = HomeRespo.fromJson((response.data));
      } else {
        model = HomeRespo.fromJson((response.data));
      }
      return model;
    } catch (e) {
      return HomeRespo();
    }
  }
}

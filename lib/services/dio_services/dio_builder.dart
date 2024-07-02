import 'package:dio/dio.dart';
import 'package:encounter_app/services/dio_services/performance_dio.dart';

import '../../network/constants.dart';
import '../secure_storage.dart';
import 'api_interceptor.dart';

class DioBuilderResponse {
  Dio dio;
  Options dioOptions;

  DioBuilderResponse({required this.dio, required this.dioOptions});
}

class DioBuilder {
  Future<DioBuilderResponse> buildNonCachedDio({
    bool hasAuth = true,
    bool shouldQueue = false,
  }) async {
    Options dioOptions = _getDioOptions();
    String? token = await checkToken();
    Dio dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: hasAuth
            ? {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }
            : {
                'Content-Type': 'application/json',
              }));
    dio.interceptors.add(DioInterceptor(dio));
    dio.interceptors.add(DioFirebasePerformanceConnector());
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Future<DioBuilderResponse> buildNonBaseUrlDio({
    bool shouldQueue = false,
  }) async {
    Options dioOptions = _getDioOptions();
    Dio dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        }));
    dio.interceptors.add(DioInterceptor(dio));
    dio.interceptors.add(DioFirebasePerformanceConnector());
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Options _getDioOptions() {
    return Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 501;
      },
    );
  }
}

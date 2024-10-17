import 'package:dio/dio.dart';
import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/constants/app_constants.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/services/service_locator.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Token Will be added here to the header if it is not null.
    options.headers["Authorization"] =
        sl<CacheHelper>().getData(key: AppConstants.token) != null
            ? 'Bearer ${sl<CacheHelper>().getData(key: AppConstants.token)}'
            : null;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printGreen('Response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printRed('Error: ${err.response?.data}');
    super.onError(err, handler);
  }
}

import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Token Will be added here to the header if it is not null.

    super.onRequest(options, handler);
  }
}

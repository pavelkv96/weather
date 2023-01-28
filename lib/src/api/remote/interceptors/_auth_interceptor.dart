import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String apikey;

  AuthInterceptor({required this.apikey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll(<String, Object?>{'apikey': apikey});
    return handler.next(options);
  }
}

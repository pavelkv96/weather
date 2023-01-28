import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather/src/common/error/error.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return handler.next(DeadlineExceededException(err));
      case DioErrorType.response:
        {
          final statusCode = err.response?.statusCode ?? -1;
          if (statusCode == 401) {
            return handler.next(UnauthenticatedException(err));
          } else if (statusCode == 404) {
            return handler.next(NotFoundException(err));
          } else if (500 <= statusCode) {
            return handler.next(InternalServerErrorException(err));
          } else if (400 <= statusCode) {
            return handler.next(UnsupportedStatusCodeException(err));
          }
        }
        break;
      case DioErrorType.cancel:
        return handler.next(CancelRequestException(err));
      case DioErrorType.other:
        if (err.error is SocketException) {
          return handler.next(NoInternetConnectionException(err));
        }
    }
    return handler.next(UnknownNetworkException(err));
  }
}

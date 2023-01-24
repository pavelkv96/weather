part of 'exception.dart';

abstract class NetworkException extends DioError {
  NetworkException(DioError e)
      : super(
          requestOptions: e.requestOptions,
          error: e.error,
          type: e.type,
          response: e.response,
        );

  @override
  String toString() {
    final msg = StringBuffer('$runtimeType [$type]: $message,\n')..write('url: ${requestOptions.uri},\n');
    if (stackTrace != null) {
      msg.write('$stackTrace');
    }
    return msg.toString();
  }
}

class CancelRequestException extends NetworkException {
  CancelRequestException(DioError e) : super(e);
}

class InternalServerErrorException extends NetworkException {
  InternalServerErrorException(DioError e) : super(e);
}

class NotFoundException extends NetworkException {
  NotFoundException(DioError e) : super(e);
}

class NoInternetConnectionException extends NetworkException {
  NoInternetConnectionException(DioError e) : super(e);
}

class DeadlineExceededException extends NetworkException {
  DeadlineExceededException(DioError e) : super(e);
}

class UnsupportedStatusCodeException extends NetworkException {
  UnsupportedStatusCodeException(DioError e) : super(e);
}

class UnauthenticatedException extends NetworkException {
  UnauthenticatedException(DioError e) : super(e);
}

class UnknownNetworkException extends NetworkException {
  UnknownNetworkException(DioError e) : super(e);
}

import 'package:dio/dio.dart' show DioError, DioErrorType;
import 'package:weather/src/common/error/error.dart';
import 'package:weather/src/common/util/error_util.dart';

Failure handleError({required Object error, required StackTrace stack}) {
  if (error is DioError) {
    if (error is CancelRequestException || error.type == DioErrorType.cancel) {
      return const NetworkFailure.cancel();
    } else if (error is UnauthenticatedException) {
      ErrorUtil.logError(error, stackTrace: stack, hint: 'Unauthenticated request');
      return const NetworkFailure.unauthenticated();
    } else if (error is InternalServerErrorException) {
      return const NetworkFailure.serverInternal();
    } else if (error is NotFoundException) {
      ErrorUtil.logError(error, stackTrace: stack, hint: 'Page not found');
      return const NetworkFailure.notFound();
    } else if (error is NoInternetConnectionException) {
      return const NetworkFailure.noConnection();
    } else if (error is DeadlineExceededException) {
      return const NetworkFailure.timeout();
    } else if (error is UnsupportedStatusCodeException) {
      final code = error.response?.statusCode ?? -1;
      ErrorUtil.logMessage(error.toString(), stackTrace: stack, hint: 'Unsupported status code $code}');
      return const NetworkFailure.unsupportedResponseCode();
    } else {
      ErrorUtil.logError(error, stackTrace: stack, hint: 'Unknown network error');
      return const NetworkFailure.unknown();
    }
  } else if (error is StorageException) {
    ErrorUtil.logError(error, stackTrace: stack, hint: 'Unknown storage error');
    return const UnknownStorageFailure();
  }
  ErrorUtil.logError(error, stackTrace: stack, hint: 'Unknown error');
  return const UnknownFailure();
}

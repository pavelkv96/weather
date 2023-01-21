import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

@sealed
abstract class ErrorUtil {
  ErrorUtil._();

  static void logMessage(
    String message, {
    required StackTrace stackTrace,
    String? hint,
    bool warning = false,
    List<String>? params,
  }) {
    try {
      if (kReleaseMode) {
        //TODO send data to crashlytics
        // FirebaseCrashlytics.instance.recordError(message, stackTrace, reason: hint, fatal: false);
      }
      l.e('$hint: $message', stackTrace);
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в ErrorUtil.logMessage', stackTrace);
    }
  }

  static void logError(Object exception, {required StackTrace stackTrace, required String hint}) {
    try {
      if (exception is String) {
        return logMessage(exception, stackTrace: stackTrace, hint: hint, warning: true);
      }
      if (kReleaseMode) {
        //TODO send data to crashlytics
        // FirebaseCrashlytics.instance.recordError(exception, stackTrace, reason: hint, fatal: true);
      }
      l.e('$hint: $exception', stackTrace);
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в ErrorUtil.logError', stackTrace);
    }
  }
}

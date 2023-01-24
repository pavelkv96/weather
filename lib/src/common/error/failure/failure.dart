import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:weather/generated/locale_keys.g.dart';

part '_network_failure.dart';

part '_storage_failure.dart';

@immutable
abstract class Failure with EquatableMixin implements Exception {
  const Failure();

  String get message;

  @override
  List<Object> get props => [runtimeType, message];
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super();

  @override
  String get message => LocaleKeys.core_failure_unknown;
}

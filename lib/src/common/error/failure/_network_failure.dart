part of 'failure.dart';

abstract class NetworkFailure extends Failure {
  const NetworkFailure() : super();

  const factory NetworkFailure.timeout() = TimeoutExceededFailure;

  const factory NetworkFailure.notFound() = NotFoundFailure;

  const factory NetworkFailure.unauthenticated() = BadRequestFailure;

  const factory NetworkFailure.unsupportedResponseCode() = BadRequestFailure;

  const factory NetworkFailure.serverInternal() = ServerInternalFailure;

  const factory NetworkFailure.noConnection() = NoInternetConnectionFailure;

  const factory NetworkFailure.cancel() = CancelRequestFailure;

  const factory NetworkFailure.unknown() = UnknownNetworkFailure;
}

class TimeoutExceededFailure extends NetworkFailure {
  const TimeoutExceededFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_request_timed_out;
}

class BadRequestFailure extends NetworkFailure {
  const BadRequestFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_server_failure_404;
}

class NotFoundFailure extends NetworkFailure {
  const NotFoundFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_server_failure_404;
}

class ServerInternalFailure extends NetworkFailure {
  const ServerInternalFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_server_failure;
}

class NoInternetConnectionFailure extends NetworkFailure {
  const NoInternetConnectionFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_not_connected_failure;
}

class CancelRequestFailure extends NetworkFailure {
  const CancelRequestFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_network_failure;
}

class UnknownNetworkFailure extends NetworkFailure {
  const UnknownNetworkFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_network_failure;
}

class UnauthenticatedFailure extends NetworkFailure {
  const UnauthenticatedFailure();

  @override
  String get message => LocaleKeys.core_failure_remote_unauthenticated_failure;
}

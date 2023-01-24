part of 'failure.dart';

abstract class StorageFailure extends Failure {
  const StorageFailure();
}

class UnknownStorageFailure extends StorageFailure {
  const UnknownStorageFailure();

  @override
  String get message => LocaleKeys.core_failure_local_database_failure;
}

part of 'exception.dart';

@immutable
class StorageException with EquatableMixin implements Exception {
  final String message;
  final StackTrace stackTrace;

  const StorageException({required this.message, required this.stackTrace});

  @override
  List<Object> get props => [message, stackTrace];
}

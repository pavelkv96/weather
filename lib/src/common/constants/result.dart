import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/src/common/error/error.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T data) = _Success;

  const factory Result.failure(Failure error) = _Failure;
}

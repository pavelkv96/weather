import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CancelCallback with EquatableMixin {
  final CancelToken token;

  const CancelCallback({required this.token});

  @override
  List<Object> get props => [token];
}

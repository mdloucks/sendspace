import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.dart';

sealed class Failure implements Exception {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

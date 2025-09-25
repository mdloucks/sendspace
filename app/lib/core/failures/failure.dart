part 'auth_failure.dart';
part 'state_failure.dart';

sealed class Failure implements Exception {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

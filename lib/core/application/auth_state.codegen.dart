import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.codegen.freezed.dart';
part 'auth_state.codegen.g.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({@Default(null) String? userId}) = _AuthState;
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    final supabaseClient = Supabase.instance.client;
    return AuthState(userId: supabaseClient.auth.currentUser?.id);
  }
}

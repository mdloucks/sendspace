import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/repositories/auth_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.codegen.freezed.dart';
part 'auth_state.codegen.g.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AsyncValue.loading()) AsyncValue<String?> userId,
  }) = _AuthState;
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    final supabaseClient = Supabase.instance.client;

    supabaseClient.auth.onAuthStateChange.listen((event) {
      final session = supabaseClient.auth.currentSession;
      final userId = session?.user.id;

      state = AuthState(userId: AsyncValue.data(userId));
    });

    return AuthState(
      userId: AsyncValue.data(supabaseClient.auth.currentUser?.id),
    );
  }

  Future<bool> login(String email, String password) async {
    final authRepository = ref.read(repositoryBundleProvider).auth;
    state = state.copyWith(userId: AsyncValue.loading());
    await Future.delayed(Duration(seconds: 1));
    try {
      await authRepository.signInWithEmail(email, password);
    } catch (e) {
      state = state.copyWith(userId: AsyncValue.error(e, StackTrace.current));
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> signup(String email, String password) async {
    final authRepository = ref.read(repositoryBundleProvider).auth;
    state = state.copyWith(userId: AsyncValue.loading());
    await Future.delayed(Duration(seconds: 1));
    try {
      await authRepository.signUpWithEmail(email, password);
    } catch (e) {
      state = state.copyWith(userId: AsyncValue.error(e, StackTrace.current));
      return Future.value(false);
    }

    return Future.value(true);
  }
}

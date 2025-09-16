import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';
import 'package:sendspace/core/data/models/dto/tables/users.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/data/types/result.dart';

part 'me_state.codegen.freezed.dart';
part 'me_state.codegen.g.dart';

@freezed
abstract class MeState with _$MeState {
  const factory MeState({
    required AsyncValue<UsersRow> user,
    required AsyncValue<List<PostsRow>> posts,
  }) = _MeState;
}

@riverpod
class MeStateNotifier extends _$MeStateNotifier {
  @override
  MeState build() {
    return MeState(
      user: const AsyncValue.loading(),
      posts: const AsyncValue.loading(),
    );
  }

  Future<void> init() async {
    await Future.wait([_loadUserProfile(), _loadUserPosts()]);
  }

  Future<void> _loadUserProfile() async {
    state = state.copyWith(user: const AsyncValue.loading());

    final userRepository = ref.watch(repositoryBundleProvider).users;

    try {
      final result = await userRepository.getCurrentUserProfile();
      switch (result) {
        case ResultData<UsersRow>():
          state = state.copyWith(user: AsyncValue.data(result.data));
        case ResultFailure<UsersRow>():
          throw Exception('Failed to fetch profile');
      }
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }

  Future<void> _loadUserPosts() async {
    state = state.copyWith(posts: const AsyncValue.loading());

    final postRepository = ref.watch(repositoryBundleProvider).posts;

    try {
      final result = await postRepository.getUserPosts();
      switch (result) {
        case ResultData<List<PostsRow>>():
          state = state.copyWith(posts: AsyncValue.data(result.data));
        case ResultFailure<List<PostsRow>>():
          throw Exception('Failed to fetch posts');
      }
    } catch (e, st) {
      state = state.copyWith(posts: AsyncValue.error(e, st));
    }
  }

  Future<void> upsertUserProfile({required UsersRow user, File? file}) async {
    state = state.copyWith(user: const AsyncValue.loading());
    final userRepository = ref.watch(repositoryBundleProvider).users;
    try {
      await userRepository.upsertUserProfile(user: user, file: file);
      await _loadUserProfile();
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }
}

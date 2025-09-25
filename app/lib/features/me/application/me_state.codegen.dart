import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/dto/tables/posts.dart';
import 'package:sendspace/core/data/dto/tables/profiles.dart';
import 'package:sendspace/core/data/models/climbing_grades.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/data/types/result.dart';
import 'package:sendspace/core/failures/failure.dart';
import 'package:sendspace/features/record/application/record_state.codegen.dart';

part 'me_state.codegen.freezed.dart';
part 'me_state.codegen.g.dart';

@freezed
abstract class MeState with _$MeState {
  const factory MeState({
    required AsyncValue<ProfilesRow> profile,
    required AsyncValue<List<PostsRow>> posts,
  }) = _MeState;
}

@Riverpod(keepAlive: true)
class MeStateNotifier extends _$MeStateNotifier {
  MeState build() {
    final initial = MeState(
      profile: const AsyncValue.loading(),
      posts: const AsyncValue.loading(),
    );

    Future.microtask(() async {
      await _init();
    });

    return initial;
  }

  Future<void> _init() async {
    await Future.wait([_loadUserProfile(), _loadUserPosts()]);
  }

  Future<void> _loadUserProfile() async {
    state = state.copyWith(profile: const AsyncValue.loading());

    final userRepository = ref.watch(repositoryBundleProvider).users;

    try {
      final result = await userRepository.getCurrentUserProfile();
      switch (result) {
        case ResultData<ProfilesRow>():
          state = state.copyWith(profile: AsyncValue.data(result.data));
        case ResultFailure<ProfilesRow>():
          throw Exception('Failed to fetch profile');
      }
    } catch (e, st) {
      state = state.copyWith(profile: AsyncValue.error(e, st));
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

  Future<void> updateClimbingLevel(String newGrade) async {
    try {
      final profileData = state.profile.requireValue;
      final newHighestGrade = ClimbingGrade.parseGrade(newGrade);
      final currentHighestGrade = ClimbingGrade.parseGrade(
        profileData.climbingLevel!,
      );

      if (newHighestGrade.rank > currentHighestGrade.rank) {
        final updated = profileData.copyWith(
          climbingLevel: newHighestGrade.name,
        );

        // Update in the repository
        await ref
            .read(repositoryBundleProvider)
            .users
            .upsertUserProfile(profile: updated);

        // Update state in the notifier
        state = state.copyWith(profile: AsyncValue.data(updated));
      }
    } catch (e, st) {
      ref
          .read(recordStateNotifierProvider.notifier)
          .setErrror(StateFailure("Failed to update climbing level"));
    }
  }

  Future<void> upsertUserProfile({
    required ProfilesRow profile,
    File? file,
  }) async {
    state = state.copyWith(profile: const AsyncValue.loading());
    final userRepository = ref.watch(repositoryBundleProvider).users;
    try {
      await userRepository.upsertUserProfile(profile: profile, file: file);
      await _loadUserProfile();
    } catch (e, st) {
      state = state.copyWith(profile: AsyncValue.error(e, st));
    }
  }
}

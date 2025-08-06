import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';
import 'package:sendspace/core/data/models/dto/tables/users.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/data/repositories/user_repository.dart';
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
  late final UserRepository _userRepository;
  late final PostRepository _postRepository;

  @override
  MeState build() {
    final bundle = ref.read(repositoryBundleProvider);
    _userRepository = bundle.users;
    _postRepository = bundle.posts;

    // Initial state is loading for both user and posts
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

    try {
      final result = await _userRepository.getCurrentUserProfile();
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
    try {
      final result = await _postRepository.getUserPosts();
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

  Future<void> refresh() async {
    await init(); // or you can split out the two loads again if needed
  }

  Future<void> updateProfile(UsersRow user) async {
    try {
      await _userRepository.upsertUserProfile(user: user);
      await _loadUserProfile();
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }
}

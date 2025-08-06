import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/data/types/result.dart';

part 'post_state.codegen.freezed.dart';
part 'post_state.codegen.g.dart';

@freezed
abstract class PostState with _$PostState {
  const factory PostState({required AsyncValue<List<PostsRow>> posts}) =
      _PostState;
}

@riverpod
class PostStateNotifier extends _$PostStateNotifier {
  late final PostRepository _postRepository;

  @override
  PostState build() {
    Future(() async {
      _postRepository = ref.read(repositoryBundleProvider).posts;

      final posts = await _postRepository.getUserPosts();

      switch (posts) {
        case ResultData<List<PostsRow>>():
          state = state.copyWith(posts: AsyncValue.data(posts.data));
        case ResultFailure<List<PostsRow>>():
          state = state.copyWith(
            posts: AsyncValue.error(posts.message, StackTrace.current),
          );
      }
    });
    return PostState(posts: AsyncValue.loading());
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/post.codegen.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/failures/failure.dart';

part 'post_state.codegen.g.dart';
part 'post_state.codegen.freezed.dart';

@freezed
abstract class PostState with _$PostState {
  const factory PostState({required AsyncValue<List<Post>> posts}) = _PostState;
}

@riverpod
class PostStateNotifier extends _$PostStateNotifier {
  late final PostRepository _postRepository;

  @override
  PostState build() {
    Future(() async {
      _postRepository = ref.read(repositoryBundleProvider).posts;

      try {
        final posts = await _postRepository.getUserPosts();
        state = state.copyWith(posts: AsyncValue.data(posts));
      } on AuthFailure catch (e) {
        state = state.copyWith(posts: AsyncValue.error(e, StackTrace.current));
      }
    });
    return PostState(posts: AsyncValue.loading());
  }
}

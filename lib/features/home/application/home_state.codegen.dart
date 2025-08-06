import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';

part 'home_state.codegen.freezed.dart';
part 'home_state.codegen.g.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({required AsyncValue<List<PostsRow>> posts}) =
      _HomeState;
}

@riverpod
class HomeStateNotifier extends _$HomeStateNotifier {
  // late final PostRepository _postRepository;

  @override
  HomeState build() {
    // _postRepository = ref.read(repositoryBundleProvider).posts;
    return HomeState(posts: AsyncValue.loading());
  }

  Future<void> init() async {}
}

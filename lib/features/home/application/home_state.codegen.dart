import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/post.codegen.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';

part 'home_state.codegen.g.dart';
part 'home_state.codegen.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({required AsyncValue<List<Post>> posts}) = _HomeState;
}

@riverpod
class HomeStateNotifier extends _$HomeStateNotifier {
  late final PostRepository _postRepository;

  @override
  HomeState build() {
    _postRepository = ref.read(repositoryBundleProvider).posts;
    return HomeState(posts: AsyncValue.loading());
  }

  Future<void> init() async {}
}

import 'package:sendspace/core/data/models/post.codegen.dart';
import 'package:sendspace/core/data/services/post_service.dart';
import 'package:sendspace/core/data/types/result.dart';

abstract class PostRepository {
  Future<Result<List<Post>>> getUserPosts();
}

class PostRepositoryImpl extends PostRepository {
  final SupabasePostService _service;

  PostRepositoryImpl(this._service);

  @override
  Future<Result<List<Post>>> getUserPosts() async {
    try {
      final data = await _service.getUserPosts();
      return Future.value(ResultData(data));
    } catch (e) {
      return Future.value(ResultFailure("Could not fetch user posts $e"));
    }
  }
}

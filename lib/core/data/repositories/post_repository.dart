import 'dart:io';

import 'package:sendspace/core/data/models/post.codegen.dart';
import 'package:sendspace/core/data/services/post_service.dart';
import 'package:sendspace/core/data/types/result.dart';

abstract class PostRepository {
  Future<Result<List<Post>>> getUserPosts();

  Future<Result<void>> createPostWithVideo({
    required Post post,
    File? videoFile,
  });
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

  @override
  Future<Result<void>> createPostWithVideo({
    required Post post,
    File? videoFile,
  }) async {
    if (post.title.trim().isEmpty) {
      return ResultFailure('Post title is required.');
    }

    if (post.climbTypeId.trim().isEmpty) {
      return ResultFailure('Climb type must be selected.');
    }

    if (videoFile != null && !videoFile.existsSync()) {
      return ResultFailure('Selected video file does not exist.');
    }

    try {
      await _service.createPost(post: post, videoFile: videoFile);
      return ResultData(null);
    } catch (e) {
      return ResultFailure(e.toString());
    }
  }
}

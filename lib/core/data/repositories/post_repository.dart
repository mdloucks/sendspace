import 'package:sendspace/core/data/models/post.codegen.dart';
import 'package:sendspace/core/failures/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PostRepository {
  Future<List<Post>> getUserPosts();
}

class PostRepositoryImpl extends PostRepository {
  final SupabaseClient _client;

  PostRepositoryImpl(this._client);

  String get tableName => 'posts';

  @override
  Future<List<Post>> getUserPosts() async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      throw AuthFailure("User is not authenticated.");
    }

    final response = await _client
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Post.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> createPost(Post post) async {
    await _client.from(tableName).insert(post.toJson());
  }

  Future<void> deletePost(String id) async {
    await _client.from(tableName).delete().eq('id', id);
  }
}

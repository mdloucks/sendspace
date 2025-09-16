import 'dart:io';

import 'package:sendspace/core/data/models/dto/tables/users.dart';
import 'package:sendspace/core/mixins/s3_bucket_mixin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class UserService {
  Future<UsersRow> getCurrentUserProfile();
  Future<void> upsertUserProfile(UsersRow user, File? file);
}

class SupabaseUserService extends UserService with S3BucketMixin {
  final SupabaseClient _client;

  SupabaseUserService({
    required SupabaseClient client,
    required String tableName,
  }) : _client = client;

  String get tableName => 'users';

  @override
  Future<UsersRow> getCurrentUserProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('No logged in user');

    final result =
        await _client.from(tableName).select().eq('id', user.id).single();

    return UsersRow.fromJson(result);
  }

  @override
  Future<void> upsertUserProfile(UsersRow user, File? file) async {
    try {
      if (file != null) {
        final objectKey = "${_client.auth.currentUser?.id}.${Uuid().v4()}";
        final publicUrl = await uploadObject(
          client: _client,
          bucketName: 'users_profile_images',
          file: file,
          objectKey: objectKey,
        );
        user.profileImageUrl = publicUrl;
      }
      await _client.from(tableName).upsert(user.toJson());
    } catch (e, st) {
      rethrow;
    }
  }
}

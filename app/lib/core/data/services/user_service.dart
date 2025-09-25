import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:sendspace/core/data/dto/tables/profiles.dart';
import 'package:sendspace/core/mixins/s3_bucket_mixin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class UserService {
  Future<ProfilesRow> getCurrentUserProfile();
  Future<void> upsertUserProfile(ProfilesRow user, File? file);
}

class SupabaseUserService extends UserService with S3BucketMixin {
  final SupabaseClient _client;

  SupabaseUserService({
    required SupabaseClient client,
    required String tableName,
  }) : _client = client;

  String get tableName => 'users';

  @override
  Future<ProfilesRow> getCurrentUserProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('No logged in user');

    final result =
        await _client.from(tableName).select().eq('id', user.id).single();

    return ProfilesRow.fromJson(result);
  }

  @override
  Future<void> upsertUserProfile(ProfilesRow user, File? file) async {
    try {
      if (file != null) {
        final objectKey = generateObjectKey(
          _client,
          'pfp',
          path.extension(file.path),
        );
        final publicUrl = await uploadObjectFromFile(
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

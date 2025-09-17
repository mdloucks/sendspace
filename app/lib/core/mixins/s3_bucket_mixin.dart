import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

mixin S3BucketMixin {
  /// Uploads an object to S3 and returns the public URL
  Future<String> uploadObject({
    required SupabaseClient client,
    required String bucketName,
    required File file,
    required String objectKey,
  }) async {
    final response = await client.storage
        .from(bucketName)
        .upload(objectKey, file);

    if (response.isEmpty) {
      throw Exception('Object upload failed for {objectKey}');
    }

    return client.storage.from(bucketName).getPublicUrl(objectKey);
  }

  String generateObjectKeyFromSupabaseClient(SupabaseClient client) =>
      "${client.auth.currentUser?.id}.${Uuid().v4()}";
}

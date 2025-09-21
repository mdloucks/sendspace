import 'dart:io';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

mixin S3BucketMixin {
  /// Uploads an object to S3 and returns the public URL
  Future<String> uploadObjectFromFile({
    required SupabaseClient client,
    required String bucketName,
    required File file,
    required String objectKey,
  }) async {
    // TODO: add retry logic here
    final response = await client.storage
        .from(bucketName)
        .upload(objectKey, file);

    if (response.isEmpty) {
      throw Exception('Object upload failed for {objectKey}');
    }

    return client.storage.from(bucketName).getPublicUrl(objectKey);
  }

  /// Uploads an object to S3 and returns the public URL
  Future<String> uploadObjectFromBinary({
    required SupabaseClient client,
    required String bucketName,
    required Uint8List data,
    required String objectKey,
  }) async {
    final response = await client.storage
        .from(bucketName)
        .uploadBinary(objectKey, data);

    if (response.isEmpty) {
      throw Exception('Object upload failed for {objectKey}');
    }

    return client.storage.from(bucketName).getPublicUrl(objectKey);
  }

  String generateObjectKey(
    SupabaseClient client,
    String type,
    String extension,
  ) {
    final userId = client.auth.currentUser?.id ?? 'anon';
    return "$userId/$type/${Uuid().v4()}.$extension";
  }
}

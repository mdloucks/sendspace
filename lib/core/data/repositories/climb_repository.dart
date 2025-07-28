import 'package:sendspace/core/data/models/climb_type.codegen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ClimbRepository {
  Future<List<ClimbType>> getClimbTypes();
}

class ClimbRepositoryImpl extends ClimbRepository {
  final SupabaseClient _client;

  ClimbRepositoryImpl(this._client);

  String get tableName => 'climb_types';

  @override
  Future<List<ClimbType>> getClimbTypes() async {
    final response = await _client
        .from(tableName)
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ClimbType.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

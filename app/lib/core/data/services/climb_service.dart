import 'package:sendspace/core/data/dto/tables/climb_types.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ClimbService {
  Future<List<ClimbTypesRow>> getClimbTypes();
}

class SupabaseClimbService extends ClimbService {
  final SupabaseClient _client;

  SupabaseClimbService(this._client);

  String get tableName => 'climb_types';

  @override
  Future<List<ClimbTypesRow>> getClimbTypes() async {
    final response = await _client
        .from(tableName)
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ClimbTypesRow.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

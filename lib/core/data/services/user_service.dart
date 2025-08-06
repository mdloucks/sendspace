import 'package:sendspace/core/data/models/dto/tables/users.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserService {
  Future<UsersRow> getCurrentUserProfile();
  Future<void> upsertUserProfile(UsersRow user);
}

class SupabaseUserService extends UserService {
  final SupabaseClient client;

  SupabaseUserService({required this.client, required String tableName});

  String get tableName => 'users';

  @override
  Future<UsersRow> getCurrentUserProfile() async {
    final user = client.auth.currentUser;
    if (user == null) throw Exception('No logged in user');

    final result =
        await client.from(tableName).select().eq('id', user.id).single();

    return UsersRow.fromJson(result);
  }

  @override
  Future<void> upsertUserProfile(UsersRow user) async {
    await client.from(tableName).upsert(user.toJson());
  }
}

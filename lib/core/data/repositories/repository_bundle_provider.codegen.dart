import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/repositories/auth_repository.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle.dart';
import 'package:sendspace/core/data/repositories/user_repository.dart';
import 'package:sendspace/core/data/services/climb_service.dart';
import 'package:sendspace/core/data/services/post_service.dart';
import 'package:sendspace/core/data/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'repository_bundle_provider.codegen.g.dart';

@riverpod
RepositoryBundle repositoryBundle(Ref ref) {
  final supabaseClient = Supabase.instance.client;

  final supabasePostService = SupabasePostService(supabaseClient);
  final supabaseClimbService = SupabaseClimbService(supabaseClient);
  // TODO: make the rest of the services match this pattern with the tableName
  final supabaseUserService = SupabaseUserService(
    client: supabaseClient,
    tableName: 'users',
  );

  return RepositoryBundleImpl(
    posts: PostRepositoryImpl(supabasePostService),
    auth: SupabaseAuthRepository(supabaseClient),
    climb: ClimbRepositoryImpl(supabaseClimbService),
    users: UserRepositoryImpl(supabaseUserService),
  );
}

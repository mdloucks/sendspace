import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/repositories/auth_repository.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle.dart';
import 'package:sendspace/core/data/services/climb_service.dart';
import 'package:sendspace/core/data/services/post_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod/riverpod.dart';

part 'repository_bundle_provider.codegen.g.dart';

@riverpod
RepositoryBundle repositoryBundle(Ref ref) {
  final supabaseClient = Supabase.instance.client;

  final supabasePostService = SupabasePostService(supabaseClient);
  final supabaseClimbService = SupabaseClimbService(supabaseClient);

  return RepositoryBundleImpl(
    posts: PostRepositoryImpl(supabasePostService),
    auth: SupabaseAuthRepository(supabaseClient),
    climb: ClimbRepositoryImpl(supabaseClimbService),
  );
}

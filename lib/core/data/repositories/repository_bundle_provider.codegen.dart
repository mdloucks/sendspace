import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/repositories/auth_repository.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod/riverpod.dart';

part 'repository_bundle_provider.codegen.g.dart';

@riverpod
RepositoryBundle repositoryBundle(Ref ref) {
  final supabaseClient = Supabase.instance.client;

  return RepositoryBundleImpl(
    posts: PostRepositoryImpl(supabaseClient),
    auth: SupabaseAuthRepository(supabaseClient),
    climb: ClimbRepositoryImpl(supabaseClient),
  );
}

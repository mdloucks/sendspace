import 'package:sendspace/core/data/repositories/auth_repository.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/user_repository.dart';

abstract class RepositoryBundle {
  final PostRepository posts;
  final AuthRepository auth;
  final ClimbRepository climb;
  final UserRepository users;

  const RepositoryBundle({
    required this.posts,
    required this.auth,
    required this.climb,
    required this.users,
  });
}

class RepositoryBundleImpl implements RepositoryBundle {
  @override
  final PostRepositoryImpl posts;

  @override
  final AuthRepository auth;

  @override
  final ClimbRepositoryImpl climb;

  @override
  final UserRepositoryImpl users;

  RepositoryBundleImpl({
    required this.posts,
    required this.auth,
    required this.climb,
    required this.users,
  });
}

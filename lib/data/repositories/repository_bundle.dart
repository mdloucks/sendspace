import 'package:sendspace/data/repositories/auth_repository.dart';
import 'package:sendspace/data/repositories/locations.dart';

abstract class RepositoryBundle {
  LocationRepository get locations;
  AuthRepository get auth;
}

class RepositoryBundleImpl implements RepositoryBundle {
  @override
  final LocationRepository locations;

  @override
  final AuthRepository auth;

  RepositoryBundleImpl({required this.locations, required this.auth});
}

import 'package:sendspace/core/data/models/dto/tables/users.dart';
import 'package:sendspace/core/data/services/user_service.dart';
import 'package:sendspace/core/data/types/result.dart';

abstract class UserRepository {
  Future<Result<UsersRow>> getCurrentUserProfile();
  Future<Result<void>> upsertUserProfile({required UsersRow user});
}

class UserRepositoryImpl extends UserRepository {
  final SupabaseUserService _service;

  UserRepositoryImpl(this._service);

  @override
  Future<Result<UsersRow>> getCurrentUserProfile() async {
    try {
      final user = await _service.getCurrentUserProfile();
      return ResultData(user);
    } catch (e) {
      return ResultFailure(e.toString());
    }
  }

  @override
  Future<Result<void>> upsertUserProfile({required UsersRow user}) async {
    try {
      await _service.upsertUserProfile(user);
      return ResultData(null);
    } catch (e) {
      return ResultFailure(e.toString());
    }
  }
}

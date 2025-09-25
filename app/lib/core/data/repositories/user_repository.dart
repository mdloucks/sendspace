import 'dart:io';

import 'package:sendspace/core/data/dto/tables/profiles.dart';
import 'package:sendspace/core/data/services/user_service.dart';
import 'package:sendspace/core/data/types/result.dart';

abstract class UserRepository {
  Future<Result<ProfilesRow>> getCurrentUserProfile();
  Future<Result<void>> upsertUserProfile({
    required ProfilesRow profile,
    File? file,
  });
}

class UserRepositoryImpl extends UserRepository {
  final SupabaseUserService _service;

  UserRepositoryImpl(this._service);

  @override
  Future<Result<ProfilesRow>> getCurrentUserProfile() async {
    try {
      final user = await _service.getCurrentUserProfile();
      return ResultData(user);
    } catch (e) {
      return ResultFailure(e.toString());
    }
  }

  @override
  Future<Result<void>> upsertUserProfile({
    required ProfilesRow profile,
    File? file,
  }) async {
    try {
      await _service.upsertUserProfile(profile, file);
      return ResultData(null);
    } catch (e) {
      return ResultFailure(e.toString());
    }
  }
}

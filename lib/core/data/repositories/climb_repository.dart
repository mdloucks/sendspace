import 'package:sendspace/core/data/models/climb_type.codegen.dart';
import 'package:sendspace/core/data/services/climb_service.dart';
import 'package:sendspace/core/data/types/result.dart';

abstract class ClimbRepository {
  Future<Result<List<ClimbType>>> getClimbTypes();
}

class ClimbRepositoryImpl extends ClimbRepository {
  final SupabaseClimbService _service;

  ClimbRepositoryImpl(this._service);

  String get tableName => 'climb_types';

  @override
  Future<Result<List<ClimbType>>> getClimbTypes() async {
    try {
      final data = await _service.getClimbTypes();
      return Future.value(ResultData(data));
    } catch (e) {
      return Future.value(ResultFailure("Could not fetch climb types $e"));
    }
  }
}

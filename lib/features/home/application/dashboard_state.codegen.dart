import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/data/application/repository_bundle_provider.codegen.dart';
import 'package:sendspace/data/models/location.dart';
import 'package:sendspace/data/repositories/locations.dart';

part 'dashboard_state.codegen.g.dart';
part 'dashboard_state.codegen.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({required AsyncValue<List<Location>> locations}) =
      _HomeState;
}

@riverpod
class HomeStateNotifier extends _$HomeStateNotifier {
  late final LocationRepository _repository;

  @override
  HomeState build() {
    _repository = ref.read(repositoryBundleProvider).locations;
    return HomeState(locations: AsyncValue.loading());
  }

  Future<void> init() async {
    try {
      final locations = await _repository.fetchLocations();
      state = state.copyWith(locations: AsyncValue.data(locations));
    } catch (e) {
      state = state.copyWith(
        locations: AsyncValue.error(
          Exception("Could not fetch locations"),
          StackTrace.current,
        ),
      );
    }
  }
}

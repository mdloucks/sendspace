import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/climb_type.codegen.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'record_state.codegen.freezed.dart';
part 'record_state.codegen.g.dart';

@freezed
abstract class RecordState with _$RecordState {
  const factory RecordState({
    @Default([]) List<ClimbType> climbTypes,
    ClimbType? selectedClimbType,
    File? selectedVideo,
    @Default(false) bool loading,
    String? error,
    @Default('') String title,
    @Default('') String description,
    @Default('') String grade,
  }) = _RecordState;
}

@riverpod
class RecordStateNotifier extends _$RecordStateNotifier {
  late final SupabaseClient client;
  late final ClimbRepository climbRepo;

  @override
  RecordState build() {
    Future(() async {
      await _loadClimbTypes();
    });

    return RecordState();
  }

  Future<void> _loadClimbTypes() async {
    state = state.copyWith(loading: true);
    try {
      final types = await climbRepo.getClimbTypes();
      state = state.copyWith(
        climbTypes: types,
        selectedClimbType: types.isNotEmpty ? types.first : null,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load climb types.',
        loading: false,
      );
    }
  }

  void setSelectedClimbType(ClimbType? type) {
    state = state.copyWith(selectedClimbType: type);
  }

  void setSelectedVideo(File? video) {
    state = state.copyWith(selectedVideo: video);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String desc) {
    state = state.copyWith(description: desc);
  }

  void setGrade(String grade) {
    state = state.copyWith(grade: grade);
  }

  Future<String?> uploadPost() async {
    final user = client.auth.currentUser;
    if (user == null) return 'User not authenticated.';
    if (state.title.isEmpty || state.selectedClimbType == null) {
      return 'Please complete all required fields.';
    }

    String? videoUrl;
    if (state.selectedVideo != null) {
      final fileName = path.basename(state.selectedVideo!.path);
      final fileKey = 'uploads/$fileName';
      final bucket = 'videos';

      final response = await client.storage
          .from(bucket)
          .upload(fileKey, state.selectedVideo!);
      if (response.isEmpty) return 'Video upload failed.';

      videoUrl = client.storage.from(bucket).getPublicUrl(fileKey);
    }

    await client.from('posts').insert({
      'title': state.title,
      'description': state.description,
      'video_url': videoUrl,
      'grade': state.grade,
      'user_id': user.id,
      'climb_type_id': state.selectedClimbType!.id,
      'created_at': DateTime.now().toIso8601String(),
    });

    // Reset form
    state = RecordState(
      climbTypes: state.climbTypes,
      selectedClimbType:
          state.climbTypes.isNotEmpty ? state.climbTypes.first : null,
    );
    return null;
  }
}

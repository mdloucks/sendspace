import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sendspace/core/data/models/dto/tables/climb_types.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';
import 'package:sendspace/core/data/repositories/post_repository.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/data/types/result.dart';

part 'record_state.codegen.freezed.dart';
part 'record_state.codegen.g.dart';

enum FormStatus { loading, ready, submitting, error }

@freezed
abstract class RecordState with _$RecordState {
  const factory RecordState({
    @Default([]) List<ClimbTypesRow> climbTypes,
    ClimbTypesRow? selectedClimbType,
    File? selectedVideo,
    String? error,
    @Default('') String title,
    @Default('') String description,
    @Default('') String grade,
    @Default(FormStatus.loading) FormStatus status,
  }) = _RecordState;
}

@riverpod
class RecordStateNotifier extends _$RecordStateNotifier {
  @override
  RecordState build() {
    Future(() async {
      await _loadClimbTypes();
    });

    return RecordState();
  }

  Future<void> _loadClimbTypes() async {
    final climbRepository = ref.watch(repositoryBundleProvider).climb;
    final types = await climbRepository.getClimbTypes();
    switch (types) {
      case ResultData<List<ClimbTypesRow>>():
        state = state.copyWith(
          climbTypes: types.data,
          status: FormStatus.ready,
        );
      case ResultFailure<List<ClimbTypesRow>>():
        state = state.copyWith(error: types.message);
    }
  }

  void setSelectedClimbType(ClimbTypesRow? type) {
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

  void uploadPost() async {
    state = state.copyWith(status: FormStatus.loading);

    final climbTypeId = state.selectedClimbType?.id;
    final postRepository = ref.watch(repositoryBundleProvider).posts;

    if (climbTypeId == null) {
      state = state.copyWith(
        status: FormStatus.error,
        error: "You need to select a climb type!",
      );
      return;
    }

    final post = PostsRow(
      title: state.title,
      climbTypeId: climbTypeId,
      grade: state.grade,
      description: state.description,
    );

    final result = await postRepository.createPostWithVideo(
      post: post,
      videoFile: state.selectedVideo,
    );

    switch (result) {
      case ResultData<void>():
        state = RecordState().copyWith(status: FormStatus.ready);
      case ResultFailure<void>():
        state = state.copyWith(
          status: FormStatus.error,
          error: "Failed to create post",
        );
    }
  }
}

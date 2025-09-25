import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/data/dto/tables/climb_types.dart';
import 'package:sendspace/core/data/dto/tables/profiles.dart';
import 'package:sendspace/core/data/models/climbing_grades.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/core/failures/failure.dart';
import 'package:sendspace/core/presentation/widgets/status_indicator.dart';
import 'package:sendspace/core/presentation/widgets/styled_elevated_button.dart';
import 'package:sendspace/features/me/application/me_state.codegen.dart';
import 'package:sendspace/features/record/application/record_state.codegen.dart';
import 'package:sendspace/theme/spacing.dart';

// TODO: clean this up, prolly after moving to bloc
//
// also, add an option to say if they sent it or not
class RecordPage extends ConsumerWidget {
  const RecordPage({super.key});

  Future<void> _pickVideo(WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      ref
          .read(recordStateNotifierProvider.notifier)
          .setSelectedVideo(File(result.files.single.path!));
    }
  }

  Future<void> _submit(WidgetRef ref, ProfilesRow? profileData) async {
    if (profileData == null) {
      ref
          .read(recordStateNotifierProvider.notifier)
          .setErrror(StateFailure("Failed to update climbing level"));
    }
    ref.read(recordStateNotifierProvider.notifier).uploadPost();
    final newGrade = ref.read(recordStateNotifierProvider).grade;
    await ref
        .read(meStateNotifierProvider.notifier)
        .updateClimbingLevel(newGrade);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(meStateNotifierProvider).profile;
    final state = ref.watch(recordStateNotifierProvider);

    if (state.status == FormStatus.loading) {
      return StatusIndicator.loading();
    }

    if (state.status == FormStatus.finished) {
      return StatusIndicator.success(message: "Post uploaded.");
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged:
                  (value) => ref
                      .read(recordStateNotifierProvider.notifier)
                      .setTitle(value),
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: state.title)
                ..selection = TextSelection.collapsed(
                  offset: state.title.length,
                ),
            ),
            const Gap(Spacing.md),
            TextField(
              onChanged:
                  (value) => ref
                      .read(recordStateNotifierProvider.notifier)
                      .setDescription(value),
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              controller: TextEditingController(text: state.description)
                ..selection = TextSelection.collapsed(
                  offset: state.description.length,
                ),
            ),
            const Gap(Spacing.md),
            DropdownMenu<ClimbTypesRow>(
              initialSelection: state.selectedClimbType,
              label:
                  state.selectedClimbType == null
                      ? Text('Select climb type')
                      : null,
              dropdownMenuEntries:
                  state.climbTypes.map((type) {
                    return DropdownMenuEntry<ClimbTypesRow>(
                      value: type,
                      labelWidget: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          type.name,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                      label: type.name,
                    );
                  }).toList(),
              onSelected:
                  (value) => ref
                      .read(recordStateNotifierProvider.notifier)
                      .setSelectedClimbType(value),
            ),
            const Gap(Spacing.md),
            TextField(
              onChanged:
                  (value) => ref
                      .read(recordStateNotifierProvider.notifier)
                      .setGrade(value),
              decoration: const InputDecoration(
                labelText: 'Grade (e.g., V5, 5.14a, 6a)',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: state.grade)
                ..selection = TextSelection.collapsed(
                  offset: state.grade.length,
                ),
            ),
            const Gap(Spacing.md),
            StyledElevatedButton.neutral(
              context: context,
              onPressed: () => _pickVideo(ref),
              icon: const Icon(Icons.video_library),
              child: Text(
                state.selectedVideo == null ? 'Pick video' : 'Change video',
              ),
            ),
            const Gap(Spacing.md),
            StyledElevatedButton.primary(
              context: context,
              onPressed: () => _submit(ref, profile.value),
              icon: Icon(Icons.send_outlined),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

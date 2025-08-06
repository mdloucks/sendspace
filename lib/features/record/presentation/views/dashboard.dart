import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/data/models/dto/tables/climb_types.dart';
import 'package:sendspace/features/record/application/record_state.codegen.dart';

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

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    ref.read(recordStateNotifierProvider.notifier).uploadPost();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recordStateNotifierProvider);

    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            DropdownButtonFormField<ClimbTypesRow>(
              value: state.selectedClimbType,
              items:
                  state.climbTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name),
                    );
                  }).toList(),
              onChanged:
                  (value) => ref
                      .read(recordStateNotifierProvider.notifier)
                      .setSelectedClimbType(value),
              decoration: const InputDecoration(
                labelText: 'Climb Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged:
                  (value) => ref
                      .read(recordStateNotifierProvider.notifier)
                      .setGrade(value),
              decoration: const InputDecoration(
                labelText: 'Boulder Grade (e.g., V5)',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: state.grade)
                ..selection = TextSelection.collapsed(
                  offset: state.grade.length,
                ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _pickVideo(ref),
              icon: const Icon(Icons.video_library),
              label: Text(
                state.selectedVideo == null ? 'Pick Video' : 'Change Video',
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => _submit(context, ref),
                child: const Text('Submit Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

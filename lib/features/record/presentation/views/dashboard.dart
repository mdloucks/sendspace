import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:sendspace/core/data/models/climb_type.codegen.dart';
import 'package:sendspace/core/failures/failure.dart';
import 'package:sendspace/core/data/repositories/climb_repository.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ClimbRepository _climbRepo = ClimbRepositoryImpl(Supabase.instance.client);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  File? _selectedVideo;
  List<ClimbType> _climbTypes = [];
  ClimbType? _selectedClimbType;
  bool _loadingClimbTypes = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadClimbTypes();
  }

  Future<void> _loadClimbTypes() async {
    try {
      final types = await _climbRepo.getClimbTypes();
      setState(() {
        _climbTypes = types;
        _selectedClimbType = types.isNotEmpty ? types.first : null;
        _loadingClimbTypes = false;
      });
    } catch (e) {
      setState(() {
        _loadError = 'Failed to load climb types.';
        _loadingClimbTypes = false;
      });
    }
  }

  Future<void> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedVideo = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadPost() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
      return;
    }

    if (_titleController.text.isEmpty || _selectedClimbType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields.')),
      );
      return;
    }

    String? videoUrl;
    if (_selectedVideo != null) {
      final fileName = path.basename(_selectedVideo!.path);
      final fileKey = 'uploads/$fileName';
      final bucket = 'videos';

      final response = await _supabase.storage
          .from(bucket)
          .upload(fileKey, _selectedVideo!);

      if (response.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video upload failed.')),
        );
        return;
      }

      videoUrl = _supabase.storage.from(bucket).getPublicUrl(fileKey);
    }

    await _supabase.from('posts').insert({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'video_url': videoUrl,
      'grade': _gradeController.text,
      'user_id': user.id,
      'climb_type_id': _selectedClimbType!.id,
      'created_at': DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post uploaded successfully!')),
    );

    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _gradeController.clear();
      _selectedVideo = null;
      _selectedClimbType = _climbTypes.isNotEmpty ? _climbTypes.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loadingClimbTypes
            ? const Center(child: CircularProgressIndicator())
            : _loadError != null
                ? Center(child: Text(_loadError!))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<ClimbType>(
                          value: _selectedClimbType,
                          decoration: const InputDecoration(
                            labelText: 'Climb Type',
                            border: OutlineInputBorder(),
                          ),
                          items: _climbTypes
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type.name),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedClimbType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _gradeController,
                          decoration: const InputDecoration(
                            labelText: 'Boulder Grade (e.g., V5)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: pickVideo,
                          icon: const Icon(Icons.video_library),
                          label: Text(
                            _selectedVideo == null ? 'Pick Video' : 'Change Video',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: uploadPost,
                            child: const Text('Submit Post'),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

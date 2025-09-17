import 'dart:io';
import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/core/presentation/widgets/loading_indicator.dart';
import 'package:sendspace/core/presentation/widgets/me_error_indicator.dart';
import 'package:sendspace/features/me/application/me_state.codegen.dart';
import 'package:sendspace/features/me/presentation/widgets/me_profile_header.dart';
import 'package:sendspace/features/record/application/record_state.codegen.dart';
import 'package:sendspace/theme/spacing.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _displaynameController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _displaynameController = TextEditingController();

    Future.microtask(() {
      final user = ref.read(meStateNotifierProvider).user;
      user.whenData((userData) {
        _usernameController.text = userData.userName;
        _displaynameController.text = userData.displayName;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _displaynameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // users_profile_images
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(meStateNotifierProvider.select((s) => s.user));

    return user.when(
      data: (userData) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                final newUserData = user.value?.copyWith(
                  userName: _usernameController.value.text,
                  displayName: _displaynameController.value.text,
                );

                if (newUserData != null) {
                  ref
                      .read(meStateNotifierProvider.notifier)
                      .upsertUserProfile(
                        user: newUserData,
                        file: _selectedImage,
                      );
                }
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(
            children: [
              const SizedBox(height: 24),
              // Profile section
              MeProfileHeader.large(
                user: userData,
                localAssetPath: _selectedImage?.path,
                trailing: ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: const Text("Change"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Username",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: "Enter username",
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Display name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _displaynameController,
                        decoration: const InputDecoration(
                          hintText: "Enter display name",
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Spacing.lg),

              // Logout
              Center(
                child: SizedBox(
                  width: 120,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text("Log Out"),
                    onPressed: () async {
                      await ref.read(repositoryBundleProvider).auth.signOut();
                      ref.invalidate(authStateNotifierProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.error,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (err, st) => const MeErrorIndicator(),
      loading: () => const LoadingIndicator(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/theme/spacing.dart';

class MePage extends ConsumerWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Gap(Spacing.xxxl),
        TextButton(
          onPressed: () async {
            await ref.read(repositoryBundleProvider).auth.signOut();
          },
          child: Text('log out'),
        ),
      ],
    );
  }
}

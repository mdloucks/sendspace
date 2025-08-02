import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/theme/spacing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MePage extends ConsumerWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabaseClient = Supabase.instance.client;
    return Column(
      children: [
        Gap(Spacing.xxxl),
        Text(supabaseClient.auth.currentUser?.email ?? ''),
        TextButton(
          onPressed: () async {
            await ref.read(repositoryBundleProvider).auth.signOut();
            ref.invalidate(authStateNotifierProvider);
          },
          child: Text('log out'),
        ),
      ],
    );
  }
}

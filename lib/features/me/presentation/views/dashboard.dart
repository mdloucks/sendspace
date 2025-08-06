import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/features/me/application/me_state.codegen.dart';
import 'package:sendspace/theme/spacing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MePage extends ConsumerStatefulWidget {
  const MePage({super.key});

  @override
  ConsumerState<MePage> createState() => _MePageState();
}

class _MePageState extends ConsumerState<MePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(meStateNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final supabaseClient = Supabase.instance.client;

    ref.listen(meStateNotifierProvider, (_, __) {});

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(Spacing.xl),
          const _ProfileHeader(),
          const Gap(Spacing.lg),
          const _UserPostsSection(),
          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        await ref.read(repositoryBundleProvider).auth.signOut();
        ref.invalidate(authStateNotifierProvider);
      },
      child: const Text('log out'),
    );
  }
}

class _ProfileHeader extends ConsumerWidget {
  const _ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(meStateNotifierProvider.select((s) => s.user));

    return user.when(
      data:
          (user) => Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(user.profileImageUrl ?? ''),
                backgroundColor: Colors.grey[300],
              ),
              const Gap(Spacing.lg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (user.climbingLevel != null)
                    Text(
                      'Climbing Level: ${user.climbingLevel}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ],
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error loading profile: $err'),
    );
  }
}

class _UserPostsSection extends ConsumerWidget {
  const _UserPostsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(meStateNotifierProvider.select((s) => s.posts));

    return posts.when(
      data:
          (posts) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Sends',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(Spacing.md),
              if (posts.isEmpty)
                const Text('You haven’t posted any climbs yet.'),
              ...posts.map((post) => _PostCard(post.title, post.grade ?? '')),
            ],
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error loading posts: $err'),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String title;
  final String grade;

  const _PostCard(this.title, this.grade, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Spacing.md),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            Text('Grade: $grade'),
          ],
        ),
      ),
    );
  }
}

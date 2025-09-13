import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/application/post_state.codegen.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/features/auth_page.dart';
import 'package:sendspace/theme/spacing.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postStateNotifierProvider);

    // climber@example.com
    // password123
    final userId = ref.watch(authStateNotifierProvider).userId;

    if (userId == null) {
      return AuthPage(key: Key('k_auth_page'));
    }

    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: postState.posts.when(
        data: (postsList) {
          return ListView(
            padding: const EdgeInsets.all(Spacing.lg),
            children: [
              Text('Welcome!', style: context.textTheme.displayLarge),
              const SizedBox(height: Spacing.lg),
              if (postsList.isEmpty)
                const Text('You haven’t posted anything yet.')
              else
                ...postsList.map((post) => _PostCard(post: post)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final PostsRow post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: Spacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: context.textTheme.titleLarge),
            const SizedBox(height: Spacing.xs),
            Text(post.description ?? 'No description'),
          ],
        ),
      ),
    );
  }
}

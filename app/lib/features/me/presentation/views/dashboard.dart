import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/data/repositories/repository_bundle_provider.codegen.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/features/me/application/me_state.codegen.dart';
import 'package:sendspace/features/me/presentation/widgets/me_app_bar.dart';
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
    ref.listen(meStateNotifierProvider, (_, __) {});

    final user = ref.watch(meStateNotifierProvider.select((s) => s.user));

    return user.when(
      data: (userData) {
        return Scaffold(
          backgroundColor: context.colorTheme.surface,
          body: CustomScrollView(
            slivers: [
              MeAppBar(user: userData),
              SliverPadding(
                padding: EdgeInsetsGeometry.only(top: Spacing.md),
                sliver: _UserPostsSection(),
              ),
            ],
          ),
        );
      },
      error: (err, st) {
        return Text('something went wrong');
      },
      loading: () {
        return CircularProgressIndicator();
      },
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

class _UserPostsSection extends ConsumerWidget {
  const _UserPostsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(meStateNotifierProvider.select((s) => s.posts));

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('You haven’t posted any climbs yet.'),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(16.0),
          // make drop-in animation with this https://www.youtube.com/watch?v=EsAz93BRRx4
          sliver: SliverAnimatedGrid(
            initialItemCount: posts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index, animation) {
              final post = posts[index];
              return FadeTransition(
                opacity: animation,
                child: _PostCard(post.title, post.grade ?? ''),
              );
            },
          ),
        );
      },
      loading:
          () => SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
      error:
          (err, stack) =>
              SliverToBoxAdapter(child: Text('Error loading posts: $err')),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background image
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Image.network(
              "https://image-cdn.essentiallysports.com/wp-content/uploads/explore-through-the-lens-alex-honnold_4x3.jpg?width=600",
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black87],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          // Positioned text to remove extra whitespace
          Positioned(
            left: Spacing.lg,
            right: Spacing.lg,
            bottom: Spacing.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // important to shrink to content
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Gap(Spacing.sm),
                Text(
                  grade,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

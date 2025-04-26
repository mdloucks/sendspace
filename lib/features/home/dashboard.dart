import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/data/models/location.dart';
import 'package:sendspace/features/home/application/dashboard_state.codegen.dart';
import 'package:sendspace/theme/spacing.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.read(homeStateNotifierProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeStateNotifierProvider);

    return Scaffold(
      body: homeState.locations.when(
        data: (locations) {
          if (locations.isEmpty) {
            return const Center(child: Text('No locations found.'));
          }
          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return _Header(location: locations[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Location location;

  const _Header({required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.lg,
      children: [
        Text(location.name, style: context.textTheme.displayLarge),
        Row(
          spacing: Spacing.md,
          children: [
            _DotSeparator(color: context.colorTheme.primary),
            // TODO: localize
            Text("${location.boulderCount} boulders"),
            // TODO: localize
            _DotSeparator(color: context.colorTheme.secondary),
            // TODO: localize
            Text("${location.topRopeCount} top rope"),
            _DotSeparator(color: context.colorTheme.tertiary),
            Text("${location.leadCount} lead"),
          ],
        ),
      ],
    );
  }
}

class _DotSeparator extends StatelessWidget {
  final Color color;

  const _DotSeparator({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

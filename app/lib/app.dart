import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/core/extensions/string.dart';
import 'package:sendspace/features/home/presentation/views/dashboard.dart';
import 'package:sendspace/features/me/presentation/views/dashboard.dart';
import 'package:sendspace/features/record/presentation/views/dashboard.dart';
import 'package:sendspace/routes/app_routes.dart';

// TODO: this is only out here to prevent hot reload from sending you to the home page.
// In general, we should avoid putting ephemeral state in global scope.
int selectedIndex = 0;

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  late final _controller = PageController(initialPage: selectedIndex);

  @override
  initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _controller.animateToPage(
      index,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authStateNotifierProvider.select((state) => state.userId), (
      previous,
      next,
    ) {
      final userId = next.value;
      if (userId == null) {
        context.goNamed(AppRoute.auth.name);
      }
    });

    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: [
            HomePage(key: Key('k_home_page')),
            RecordPage(key: Key('k_record_page')),
            MePage(key: Key('k_me_page')),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: context.colorTheme.surfaceDim,
        indicatorColor: context.colorTheme.primary,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: AppRoute.home.name.firstLetterCapitalized(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.notes_outlined),
            label: AppRoute.record.name.firstLetterCapitalized(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_outlined),
            label: AppRoute.me.name.firstLetterCapitalized(),
          ),
        ],
      ),
    );
  }
}

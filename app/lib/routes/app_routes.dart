import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sendspace/app.dart';
import 'package:sendspace/features/auth_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

enum AppRoute {
  home('/home', 'home'),
  record('/record', 'record'),
  me('/me', 'me'),
  auth('/auth', 'auth');

  final String path;
  final String name;

  const AppRoute(this.path, this.name);
}

GoRouter getAppRouter(AppRoute initialPath) => GoRouter(
  initialLocation: initialPath.path,
  routes: [
    // Leaving this outside of the core shell route because imo auth should be
    // completely separate from the main app.
    GoRoute(
      path: AppRoute.auth.path,
      name: AppRoute.auth.name,
      //builder: (context, state) => const AuthPage(),
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AuthPage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(key: Key('k_main_scaffold'));
      },
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const SizedBox.shrink(),
        ),
      ],
    ),
  ],
);

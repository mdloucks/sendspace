import 'package:go_router/go_router.dart';
import 'package:sendspace/app.dart';
import 'package:sendspace/features/home/presentation/views/dashboard.dart';
import 'package:sendspace/features/me/presentation/views/dashboard.dart';
import 'package:sendspace/features/record/presentation/views/dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppRoutePaths {
  static const String home = '/home';
  static const String record = '/record';
  static const String me = '/me';
}

class AppRouteNames {
  static const String home = 'home';
  static const String record = 'record';
  static const String me = 'me';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutePaths.home,
          builder: (context, state) => const HomePage(),
          name: AppRouteNames.home,
        ),
        GoRoute(
          path: AppRoutePaths.record,
          builder: (context, state) => const RecordPage(),
          name: AppRouteNames.record,
        ),
        GoRoute(
          path: AppRoutePaths.me,
          builder: (context, state) => MePage(),
          name: AppRouteNames.me,
        ),
      ],
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sendspace/core/application/auth_state.codegen.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/routes/app_routes.dart';
import 'package:sendspace/theme/app_colors.dart';
import 'package:sendspace/theme/spacing.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  Future<void> _authenticate(WidgetRef ref) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    var authedSuccessfully = false;

    if (_isLogin) {
      authedSuccessfully = await ref
          .read(authStateNotifierProvider.notifier)
          .login(email, password);
    } else {
      authedSuccessfully = await ref
          .read(authStateNotifierProvider.notifier)
          .signup(email, password);
    }

    ref.invalidate(authStateNotifierProvider);

    if (authedSuccessfully) {
      context.goNamed(AppRoute.home.name);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _emailController.value = TextEditingValue(text: 'user1@example.com');
    _passwordController.value = TextEditingValue(text: 'password123');
    final mainContent = ref
        .watch(authStateNotifierProvider)
        .userId
        .when(
          data: (data) {
            return _loginForm(context);
          },
          error: (e, st) {
            return _loginForm(context, error: e.toString());
          },
          loading: () {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator.adaptive(key: Key('k_auth_loader')),
                  Gap(Spacing.sm),
                  Text('Logging in...'),
                ],
              ),
            );
          },
        );

    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: Padding(padding: const EdgeInsets.all(16.0), child: mainContent),
    );
  }

  Column _loginForm(BuildContext context, {String? error = ''}) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const Gap(Spacing.lg),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const Gap(Spacing.md),
        ElevatedButton.icon(
          onPressed: () => _authenticate(ref),
          icon: Icon(Icons.lock_outlined),
          label: Text(_isLogin ? 'Login' : 'Sign Up'),
        ),
        TextButton(
          onPressed: () => setState(() => _isLogin = !_isLogin),
          child: Text(
            style: context.textTheme.labelLarge,
            _isLogin
                ? 'Don’t have an account? Sign Up'
                : 'Already have an account? Login',
          ),
        ),
        Text(
          error ?? '',
          style: context.textTheme.labelLarge?.copyWith(
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}

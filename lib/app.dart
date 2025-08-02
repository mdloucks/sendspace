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

class MainScaffold extends ConsumerStatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _selectedIndex = 0;
  final _controller = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            HomePage(key: Key('k_home_page')),
            RecordPage(key: Key('k_record_page')),
            MePage(key: Key('k_me_page')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: context.colorTheme.primary,
        unselectedItemColor: context.colorTheme.secondary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppRoute.home.name.firstLetterCapitalized(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: AppRoute.record.name.firstLetterCapitalized(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppRoute.me.name.firstLetterCapitalized(),
          ),
        ],
      ),
    );
  }
}

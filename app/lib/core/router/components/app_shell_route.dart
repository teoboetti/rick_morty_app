import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/core/router/routes.dart';

class AppShellRoutePage extends StatelessWidget {
  const AppShellRoutePage({
    required this.child,
    super.key,
  });

  final Widget child;

  int getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.contains(const SearchRoute().location)) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              const HomeRoute().go(context);
            case 1:
              const SearchRoute().go(context);
          }
        },
      ),
    );
  }
}

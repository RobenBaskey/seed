import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import 'role_navigation.dart';

/// The reusable chrome every primary tab destination is wrapped in: a
/// Scaffold with a role-aware bottom nav bar built from
/// [RoleNavigation.primaryTabsFor]. Every tab is a real GetX route —
/// tapping one navigates via `Get.offNamed`, so the back button and
/// route guards behave exactly as they would for a direct/deep link.
///
/// Pages reached from the "More" list (Notifications, Profile) are
/// pushed on top instead and intentionally don't use this shell, so
/// they read as a detail screen rather than a sibling tab.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final currentRoute = Get.currentRoute;

    return Obx(() {
      final role = authController.currentUser.value?.role;
      final tabs = role == null ? const <AppNavItem>[] : RoleNavigation.primaryTabsFor(role);
      final selectedIndex = tabs.indexWhere((tab) => tab.route == currentRoute);

      return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: tabs.isEmpty
            ? null
            : NavigationBar(
                selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
                onDestinationSelected: (index) {
                  final target = tabs[index].route;
                  if (target != currentRoute) Get.offNamed(target);
                },
                destinations: [
                  for (final tab in tabs)
                    NavigationDestination(
                      icon: Icon(tab.icon),
                      selectedIcon: Icon(tab.selectedIcon),
                      label: tab.label,
                    ),
                ],
              ),
      );
    });
  }
}

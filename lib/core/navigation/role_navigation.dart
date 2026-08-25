import 'package:flutter/material.dart';

import '../../features/auth/domain/entities/user_role.dart';
import '../routes/app_routes.dart';

/// One destination in the bottom tab bar: label, icon (outlined for
/// unselected, filled for selected — standard Material 3 nav styling),
/// and the route it opens.
class AppNavItem {
  const AppNavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String route;
}

/// The single source of truth for role-based navigation: which tabs a
/// given [UserRole] sees, in what order. [AppShell] reads this to build
/// the bottom nav bar, and [RoleGuardMiddleware] reads it to decide
/// whether a route may be opened at all — so the tabs shown and the
/// routes actually reachable can never drift apart.
///
/// Every role's list ends with "More": a shared destination (Notifications,
/// Profile, Logout) that doesn't need its own per-role variant.
class RoleNavigation {
  const RoleNavigation._();

  static List<AppNavItem> primaryTabsFor(UserRole role) {
    final home = AppNavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      route: AppRoutes.dashboardForRole(role),
    );

    return switch (role) {
      UserRole.salesRepresentative => [home, _dealers, _orders, _field, _more],
      UserRole.manager => [home, _sales, _dealers, _orders, _more],
      UserRole.fieldOfficer => [home, _farmers, _field, _activities, _more],
      UserRole.dealer => [home, _products, _orders, _payments, _more],
      UserRole.admin => [home, _sales, _users, _reports, _more],
    };
  }

  /// Every role whose tab bar includes [route] — the login page, and
  /// nothing else, needs to reverse this; everyone else just needs
  /// [primaryTabsFor]. An empty result means the route isn't tied to any
  /// role's tabs (e.g. Notifications, Profile) and is open to any
  /// signed-in user.
  static Set<UserRole> allowedRolesForRoute(String route) {
    return UserRole.values.where((role) => primaryTabsFor(role).any((item) => item.route == route)).toSet();
  }

  static const _dealers = AppNavItem(
    label: 'Dealers',
    icon: Icons.storefront_outlined,
    selectedIcon: Icons.storefront_rounded,
    route: AppRoutes.dealers,
  );

  static const _orders = AppNavItem(
    label: 'Orders',
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long_rounded,
    route: AppRoutes.orders,
  );

  static const _field = AppNavItem(
    label: 'Field',
    icon: Icons.map_outlined,
    selectedIcon: Icons.map_rounded,
    route: AppRoutes.visits,
  );

  static const _sales = AppNavItem(
    label: 'Sales',
    icon: Icons.insights_outlined,
    selectedIcon: Icons.insights_rounded,
    route: AppRoutes.sales,
  );

  static const _farmers = AppNavItem(
    label: 'Farmers',
    icon: Icons.agriculture_outlined,
    selectedIcon: Icons.agriculture_rounded,
    route: AppRoutes.farmers,
  );

  static const _activities = AppNavItem(
    label: 'Activities',
    icon: Icons.task_alt_outlined,
    selectedIcon: Icons.task_alt_rounded,
    route: AppRoutes.activities,
  );

  static const _products = AppNavItem(
    label: 'Products',
    icon: Icons.inventory_2_outlined,
    selectedIcon: Icons.inventory_2_rounded,
    route: AppRoutes.products,
  );

  static const _payments = AppNavItem(
    label: 'Payments',
    icon: Icons.payments_outlined,
    selectedIcon: Icons.payments_rounded,
    route: AppRoutes.payments,
  );

  static const _users = AppNavItem(
    label: 'Users',
    icon: Icons.group_outlined,
    selectedIcon: Icons.group_rounded,
    route: AppRoutes.users,
  );

  static const _reports = AppNavItem(
    label: 'Reports',
    icon: Icons.assessment_outlined,
    selectedIcon: Icons.assessment_rounded,
    route: AppRoutes.reports,
  );

  static const _more = AppNavItem(
    label: 'More',
    icon: Icons.more_horiz_rounded,
    selectedIcon: Icons.more_horiz_rounded,
    route: AppRoutes.more,
  );
}

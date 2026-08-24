import 'package:flutter/material.dart';

import '../../features/auth/domain/entities/permission.dart';
import '../routes/app_routes.dart';

/// One entry in the role-filtered dashboard menu: where it goes and the
/// permission required to see it.
class AppNavItem {
  const AppNavItem({
    required this.label,
    required this.icon,
    required this.route,
    required this.permission,
  });

  final String label;
  final IconData icon;
  final String route;
  final Permission permission;
}

/// Every navigable feature destination. [AppNavItem.permission] is what
/// [UserRolePermissions] is checked against to decide, per signed-in
/// role, which of these to show.
class AppNavItems {
  const AppNavItems._();

  static const List<AppNavItem> all = [
    AppNavItem(
      label: 'Dealers',
      icon: Icons.storefront_outlined,
      route: AppRoutes.dealers,
      permission: Permission.manageDealers,
    ),
    AppNavItem(
      label: 'Farmers',
      icon: Icons.agriculture_outlined,
      route: AppRoutes.farmers,
      permission: Permission.manageFarmers,
    ),
    AppNavItem(
      label: 'Products',
      icon: Icons.inventory_2_outlined,
      route: AppRoutes.products,
      permission: Permission.manageProducts,
    ),
    AppNavItem(
      label: 'Orders',
      icon: Icons.receipt_long_outlined,
      route: AppRoutes.orders,
      permission: Permission.viewOrders,
    ),
    AppNavItem(
      label: 'Visits',
      icon: Icons.map_outlined,
      route: AppRoutes.visits,
      permission: Permission.manageVisits,
    ),
    AppNavItem(
      label: 'Collections',
      icon: Icons.payments_outlined,
      route: AppRoutes.collections,
      permission: Permission.manageCollections,
    ),
    AppNavItem(
      label: 'Notifications',
      icon: Icons.notifications_outlined,
      route: AppRoutes.notifications,
      permission: Permission.viewDashboard,
    ),
    AppNavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      route: AppRoutes.profile,
      permission: Permission.manageOwnProfile,
    ),
  ];
}

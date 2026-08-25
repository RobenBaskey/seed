// Verifies the role -> tabs mapping matches the spec exactly, and that
// the derived route -> allowed-roles lookup (the same thing
// RoleGuardMiddleware and AppShell both read) is consistent with it.

import 'package:flutter_test/flutter_test.dart';
import 'package:seed/core/navigation/role_navigation.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/features/auth/domain/entities/user_role.dart';

void main() {
  List<String> labelsFor(UserRole role) =>
      RoleNavigation.primaryTabsFor(role).map((tab) => tab.label).toList();

  group('Primary tabs match the spec exactly, in order', () {
    test('Sales Representative: Home, Dealers, Orders, Field, More', () {
      expect(
        labelsFor(UserRole.salesRepresentative),
        ['Home', 'Dealers', 'Orders', 'Field', 'More'],
      );
    });

    test('Manager: Home, Sales, Dealers, Orders, More', () {
      expect(labelsFor(UserRole.manager), ['Home', 'Sales', 'Dealers', 'Orders', 'More']);
    });

    test('Field Officer: Home, Farmers, Field, Activities, More', () {
      expect(
        labelsFor(UserRole.fieldOfficer),
        ['Home', 'Farmers', 'Field', 'Activities', 'More'],
      );
    });

    test('Dealer: Home, Products, Orders, Payments, More', () {
      expect(labelsFor(UserRole.dealer), ['Home', 'Products', 'Orders', 'Payments', 'More']);
    });

    test('Admin: Home, Sales, Users, Reports, More', () {
      expect(labelsFor(UserRole.admin), ['Home', 'Sales', 'Users', 'Reports', 'More']);
    });
  });

  test('Every tab route is unique within a role\'s own tab bar', () {
    for (final role in UserRole.values) {
      final routes = RoleNavigation.primaryTabsFor(role).map((tab) => tab.route).toList();
      expect(routes.toSet().length, routes.length, reason: '$role has a duplicate tab route');
    }
  });

  test('Home always routes to that role\'s own dashboard', () {
    for (final role in UserRole.values) {
      final home = RoleNavigation.primaryTabsFor(role).first;
      expect(home.label, 'Home');
      expect(home.route, AppRoutes.dashboardForRole(role));
    }
  });

  group('allowedRolesForRoute', () {
    test('Dealers is Sales Rep + Manager only', () {
      expect(
        RoleNavigation.allowedRolesForRoute(AppRoutes.dealers),
        {UserRole.salesRepresentative, UserRole.manager},
      );
    });

    test('Orders is Sales Rep + Manager + Dealer', () {
      expect(
        RoleNavigation.allowedRolesForRoute(AppRoutes.orders),
        {UserRole.salesRepresentative, UserRole.manager, UserRole.dealer},
      );
    });

    test('Field (visits) is Sales Rep + Field Officer', () {
      expect(
        RoleNavigation.allowedRolesForRoute(AppRoutes.visits),
        {UserRole.salesRepresentative, UserRole.fieldOfficer},
      );
    });

    test('Sales is Manager + Admin only', () {
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.sales), {UserRole.manager, UserRole.admin});
    });

    test('Users and Reports are Admin only', () {
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.users), {UserRole.admin});
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.reports), {UserRole.admin});
    });

    test('Farmers and Activities are Field Officer only', () {
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.farmers), {UserRole.fieldOfficer});
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.activities), {UserRole.fieldOfficer});
    });

    test('Products and Payments are Dealer only', () {
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.products), {UserRole.dealer});
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.payments), {UserRole.dealer});
    });

    test('More is open to every role', () {
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.more), UserRole.values.toSet());
    });

    test('Notifications and Profile have no role restriction (open to any signed-in user)', () {
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.notifications), isEmpty);
      expect(RoleNavigation.allowedRolesForRoute(AppRoutes.profile), isEmpty);
    });

    test('Each dashboard route belongs to exactly its own role', () {
      for (final role in UserRole.values) {
        expect(
          RoleNavigation.allowedRolesForRoute(AppRoutes.dashboardForRole(role)),
          {role},
        );
      }
    });
  });
}

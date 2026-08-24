import 'user_role.dart';

/// Fine-grained capabilities that features can gate behind. A [UserRole]
/// maps to a fixed set of these via [UserRolePermissions.permissions].
enum Permission {
  manageUsers,
  manageDealers,
  manageFarmers,
  manageProducts,
  manageOrders,
  viewOrders,
  manageVisits,
  manageCollections,
  viewReports,
  viewDashboard,
  manageOwnProfile;

  String get displayName => switch (this) {
        Permission.manageUsers => 'Manage Users',
        Permission.manageDealers => 'Manage Dealers',
        Permission.manageFarmers => 'Manage Farmers',
        Permission.manageProducts => 'Manage Products',
        Permission.manageOrders => 'Manage Orders',
        Permission.viewOrders => 'View Orders',
        Permission.manageVisits => 'Manage Visits',
        Permission.manageCollections => 'Manage Collections',
        Permission.viewReports => 'View Reports',
        Permission.viewDashboard => 'View Dashboard',
        Permission.manageOwnProfile => 'Manage Own Profile',
      };
}

/// The role -> permission set mapping. This is the single source of
/// truth consulted by route middlewares and UI (nav items, action
/// buttons) to decide what a signed-in user may see or do.
extension UserRolePermissions on UserRole {
  static const Map<UserRole, Set<Permission>> _rolePermissions = {
    UserRole.admin: {
      Permission.manageUsers,
      Permission.manageDealers,
      Permission.manageFarmers,
      Permission.manageProducts,
      Permission.manageOrders,
      Permission.viewOrders,
      Permission.manageVisits,
      Permission.manageCollections,
      Permission.viewReports,
      Permission.viewDashboard,
      Permission.manageOwnProfile,
    },
    UserRole.manager: {
      Permission.manageDealers,
      Permission.manageFarmers,
      Permission.manageProducts,
      Permission.manageOrders,
      Permission.viewOrders,
      Permission.manageVisits,
      Permission.manageCollections,
      Permission.viewReports,
      Permission.viewDashboard,
      Permission.manageOwnProfile,
    },
    UserRole.salesRepresentative: {
      Permission.manageDealers,
      Permission.manageProducts,
      Permission.manageOrders,
      Permission.viewOrders,
      Permission.viewDashboard,
      Permission.manageOwnProfile,
    },
    UserRole.fieldOfficer: {
      Permission.manageFarmers,
      Permission.manageVisits,
      Permission.manageCollections,
      Permission.viewDashboard,
      Permission.manageOwnProfile,
    },
    UserRole.dealer: {
      Permission.viewOrders,
      Permission.viewDashboard,
      Permission.manageOwnProfile,
    },
  };

  Set<Permission> get permissions => _rolePermissions[this] ?? const {};

  bool hasPermission(Permission permission) => permissions.contains(permission);
}

import '../../features/auth/domain/entities/user_role.dart';

/// Named route constants. Referenced by [AppPages] and by
/// `Get.toNamed(...)` calls throughout the app instead of raw strings.
class AppRoutes {
  const AppRoutes._();

  static const String login = '/login';

  // One route per role so "log in as X" visibly lands on "X Dashboard" —
  // see [dashboardForRole]. All five currently render the same
  // DashboardPage, filtered per-role by permission; that's an
  // implementation detail, not the routing contract.
  static const String adminDashboard = '/admin-dashboard';
  static const String managerDashboard = '/manager-dashboard';
  static const String salesDashboard = '/sales-dashboard';
  static const String fieldDashboard = '/field-dashboard';
  static const String dealerDashboard = '/dealer-dashboard';

  static const String dealers = '/dealers';
  static const String farmers = '/farmers';
  static const String products = '/products';
  static const String orders = '/orders';
  static const String visits = '/visits';
  static const String collections = '/collections';
  static const String notifications = '/notifications';
  static const String profile = '/profile';

  static const List<String> dashboardRoutes = [
    adminDashboard,
    managerDashboard,
    salesDashboard,
    fieldDashboard,
    dealerDashboard,
  ];

  /// The dashboard route a signed-in user of [role] should land on —
  /// the single source of truth for post-login and route-guard
  /// redirects, so the role -> route mapping only lives in one place.
  static String dashboardForRole(UserRole role) => switch (role) {
        UserRole.admin => adminDashboard,
        UserRole.manager => managerDashboard,
        UserRole.salesRepresentative => salesDashboard,
        UserRole.fieldOfficer => fieldDashboard,
        UserRole.dealer => dealerDashboard,
      };
}

import 'package:get/get.dart';

import '../../features/activities/presentation/bindings/activities_binding.dart';
import '../../features/activities/presentation/pages/activities_page.dart';
import '../../features/auth/presentation/bindings/auth_binding.dart';
import '../../features/auth/presentation/middlewares/auth_middleware.dart';
import '../../features/auth/presentation/middlewares/role_guard_middleware.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/bindings/dashboard_binding.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dealers/presentation/bindings/dealers_binding.dart';
import '../../features/dealers/presentation/pages/dealers_page.dart';
import '../../features/farmers/presentation/bindings/farmers_binding.dart';
import '../../features/farmers/presentation/pages/farmers_page.dart';
import '../../features/more/presentation/bindings/more_binding.dart';
import '../../features/more/presentation/pages/more_page.dart';
import '../../features/notifications/presentation/bindings/notifications_binding.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/orders/presentation/bindings/orders_binding.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/payments/presentation/bindings/payments_binding.dart';
import '../../features/payments/presentation/pages/payments_page.dart';
import '../../features/products/presentation/bindings/products_binding.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/profile/presentation/bindings/profile_binding.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/reports/presentation/bindings/reports_binding.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/sales/presentation/bindings/sales_binding.dart';
import '../../features/sales/presentation/pages/sales_page.dart';
import '../../features/users/presentation/bindings/users_binding.dart';
import '../../features/users/presentation/pages/users_page.dart';
import '../../features/visits/presentation/bindings/visits_binding.dart';
import '../../features/visits/presentation/pages/visits_page.dart';
import 'app_routes.dart';

/// GetX route table. Each entry pairs a page with the binding that
/// provisions its controller(s), plus the middlewares that guard it:
/// [AuthMiddleware] requires a signed-in user, [RoleGuardMiddleware]
/// additionally requires the user's role to be one that
/// `RoleNavigation` grants this route to (see core/navigation/
/// role_navigation.dart — the same config that builds the bottom nav).
class AppPages {
  const AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    ...AppRoutes.dashboardRoutes.map(
      (route) => GetPage(
        name: route,
        page: () => const DashboardPage(),
        binding: DashboardBinding(),
        middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
      ),
    ),
    GetPage(
      name: AppRoutes.dealers,
      page: () => const DealersPage(),
      binding: DealersBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.farmers,
      page: () => const FarmersPage(),
      binding: FarmersBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsPage(),
      binding: ProductsBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersPage(),
      binding: OrdersBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.visits,
      page: () => const VisitsPage(),
      binding: VisitsBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.sales,
      page: () => const SalesPage(),
      binding: SalesBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.users,
      page: () => const UsersPage(),
      binding: UsersBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.reports,
      page: () => const ReportsPage(),
      binding: ReportsBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.activities,
      page: () => const ActivitiesPage(),
      binding: ActivitiesBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.payments,
      page: () => const PaymentsPage(),
      binding: PaymentsBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.more,
      page: () => const MorePage(),
      binding: MoreBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware(), RoleGuardMiddleware()],
    ),
  ];
}

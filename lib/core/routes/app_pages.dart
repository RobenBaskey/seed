import 'package:get/get.dart';

import '../../features/auth/presentation/bindings/auth_binding.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/collections/presentation/bindings/collections_binding.dart';
import '../../features/collections/presentation/pages/collections_page.dart';
import '../../features/dashboard/presentation/bindings/dashboard_binding.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dealers/presentation/bindings/dealers_binding.dart';
import '../../features/dealers/presentation/pages/dealers_page.dart';
import '../../features/farmers/presentation/bindings/farmers_binding.dart';
import '../../features/farmers/presentation/pages/farmers_page.dart';
import '../../features/notifications/presentation/bindings/notifications_binding.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/orders/presentation/bindings/orders_binding.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/products/presentation/bindings/products_binding.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/profile/presentation/bindings/profile_binding.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/visits/presentation/bindings/visits_binding.dart';
import '../../features/visits/presentation/pages/visits_page.dart';
import 'app_routes.dart';

/// GetX route table. Each entry pairs a page with the binding that
/// provisions its controller(s) via `Get.lazyPut`.
class AppPages {
  const AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.dealers,
      page: () => const DealersPage(),
      binding: DealersBinding(),
    ),
    GetPage(
      name: AppRoutes.farmers,
      page: () => const FarmersPage(),
      binding: FarmersBinding(),
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersPage(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.visits,
      page: () => const VisitsPage(),
      binding: VisitsBinding(),
    ),
    GetPage(
      name: AppRoutes.collections,
      page: () => const CollectionsPage(),
      binding: CollectionsBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}

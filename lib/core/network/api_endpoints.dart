/// Central registry of API endpoint paths (relative to
/// [ApiConstants.baseUrl]). Populate per feature as backend integration
/// begins; nothing here is called yet.
class ApiEndpoints {
  const ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Dashboard
  static const String dashboardSummary = '/dashboard/summary';

  // Dealers / Farmers / Products / Orders / Visits / Collections
  static const String dealers = '/dealers';
  static const String farmers = '/farmers';
  static const String products = '/products';
  static const String orders = '/orders';
  static const String visits = '/visits';
  static const String collections = '/collections';

  // Notifications / Profile
  static const String notifications = '/notifications';
  static const String profile = '/profile';
}

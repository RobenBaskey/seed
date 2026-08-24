import '../entities/user.dart';

/// Auth contract consumed by use cases. [AuthRepositoryImpl] backs this
/// with a demo data source today; swap in a Dio-based remote data source
/// later without touching this interface or any of its callers.
abstract class AuthRepository {
  Future<User> login({required String email, required String password});

  Future<void> logout();

  /// Returns the persisted session's user, or `null` if nobody is logged
  /// in. Used to restore the session on app start.
  Future<User?> getCurrentUser();
}

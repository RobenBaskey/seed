import '../entities/user.dart';

/// Auth contract consumed by use cases. [AuthRepositoryImpl] backs this
/// with a demo data source today; swap in a Dio-based remote data source
/// later without touching this interface or any of its callers.
abstract class AuthRepository {
  /// When [rememberMe] is false the session is kept in memory for this
  /// run only — nothing is persisted, so the user is signed out again
  /// the next time the app starts.
  Future<User> login({required String email, required String password, bool rememberMe = true});

  Future<void> logout();

  /// Returns the persisted session's user, or `null` if nobody is logged
  /// in. Used to restore the session on app start.
  Future<User?> getCurrentUser();
}

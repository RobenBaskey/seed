import 'package:seed/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:seed/features/auth/data/models/user_model.dart';

/// In-memory stand-in for [AuthLocalDataSource], so tests don't need a
/// real platform-backed storage plugin (GetStorage needs one, which
/// isn't available under `flutter test`).
class FakeAuthLocalDataSource implements AuthLocalDataSource {
  UserModel? _cached;

  @override
  Future<void> cacheUser(UserModel user) async => _cached = user;

  @override
  Future<UserModel?> getCachedUser() async => _cached;

  @override
  Future<void> clearUser() async => _cached = null;
}

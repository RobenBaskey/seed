import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Persists the logged-in user's session locally so it survives app
/// restarts. Backed by [GetStorage] today; swap the implementation if
/// the storage mechanism changes — the repository only depends on this
/// interface.
abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._storage);

  static const String _userKey = 'cached_user';

  final GetStorage _storage;

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await _storage.write(_userKey, jsonEncode(user.toJson()));
    } catch (_) {
      throw const CacheException(message: 'Failed to save session');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final raw = _storage.read<String>(_userKey);
      if (raw == null) return null;
      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      throw const CacheException(message: 'Failed to load session');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _storage.remove(_userKey);
    } catch (_) {
      throw const CacheException(message: 'Failed to clear session');
    }
  }
}

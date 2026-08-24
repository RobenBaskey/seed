// Private fields are assigned from public-named constructor params on
// purpose so the class is still constructible by name from other files
// (an initializing formal on a private field can't be).
// ignore_for_file: prefer_initializing_formals
import '../../../../core/errors/error_mapper.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final user = await _remoteDataSource.login(email: email, password: password);
      await _localDataSource.cacheUser(user);
      return user;
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _localDataSource.clearUser();
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await _localDataSource.getCachedUser();
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}

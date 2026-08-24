import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/demo_account.dart';
import '../models/user_model.dart';

/// Talks to the backend auth endpoint. Only a demo implementation exists
/// today — [DemoAuthRemoteDataSourceImpl] checks credentials against
/// [DemoAccounts] and simulates network latency. Swap it for a Dio-based
/// implementation (using `core/network/DioClient`) once the real API
/// exists; callers depend on this interface, not the implementation, so
/// nothing else needs to change.
abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class DemoAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final account = DemoAccounts.findByEmail(email);
    if (account == null || account.password != password) {
      throw const UnauthorizedException(message: 'Invalid email or password');
    }

    return UserModel(
      id: account.id,
      name: account.name,
      email: account.email,
      role: account.role,
    );
  }
}

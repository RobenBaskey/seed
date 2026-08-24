import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Restores a previously persisted session, if any. Called once on app
/// start so a returning user skips the login screen.
class GetCurrentUserUseCase implements UseCase<User?, NoParams> {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<User?> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}

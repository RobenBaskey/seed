import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password, this.rememberMe = true});

  final String email;
  final String password;
  final bool rememberMe;

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class LoginUseCase implements UseCase<User, LoginParams> {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<User> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password, rememberMe: params.rememberMe);
  }
}

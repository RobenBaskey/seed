import 'package:equatable/equatable.dart';

import 'user_role.dart';

/// The authenticated user. Presentation and domain code depend on this,
/// never on [UserModel] — see data/models/user_model.dart for the
/// serializable counterpart.
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;

  @override
  List<Object?> get props => [id, name, email, role];
}

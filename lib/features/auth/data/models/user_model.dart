import '../../domain/entities/user.dart';
import '../../domain/entities/user_role.dart';

/// Data-layer representation of [User] with JSON (de)serialization. Kept
/// separate from the domain entity so backend field-name changes don't
/// ripple into domain/presentation code.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.fromValue(json['role'] as String),
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(id: user.id, name: user.name, email: user.email, role: user.role);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.value,
    };
  }
}

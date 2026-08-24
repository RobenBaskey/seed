/// The five roles supported by the app. Drives navigation and permission
/// checks throughout the UI — see [UserRolePermissions].
enum UserRole {
  admin,
  manager,
  salesRepresentative,
  fieldOfficer,
  dealer;

  String get displayName => switch (this) {
        UserRole.admin => 'Admin',
        UserRole.manager => 'Manager',
        UserRole.salesRepresentative => 'Sales Representative',
        UserRole.fieldOfficer => 'Field Officer',
        UserRole.dealer => 'Dealer',
      };

  /// Stable identifier used for (de)serialization. Intentionally
  /// independent of [displayName] so relabeling a role in the UI never
  /// breaks stored/cached data.
  String get value => name;

  static UserRole fromValue(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => throw ArgumentError('Unknown UserRole value: $value'),
    );
  }
}

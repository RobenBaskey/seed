import 'user_role.dart';

/// A hardcoded demo credential for one of the 5 seed roles.
///
/// This exists purely to support demo authentication (see
/// `DemoAuthRemoteDataSourceImpl`) and the "quick fill" shortcuts on the
/// login screen. Delete this file once real API authentication replaces
/// the demo data source.
class DemoAccount {
  const DemoAccount({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;
}

class DemoAccounts {
  const DemoAccounts._();

  static const List<DemoAccount> all = [
    DemoAccount(
      id: 'usr_admin',
      name: 'Admin User',
      email: 'admin@seedapp.com',
      password: '123456',
      role: UserRole.admin,
    ),
    DemoAccount(
      id: 'usr_manager',
      name: 'Manager User',
      email: 'manager@seedapp.com',
      password: '123456',
      role: UserRole.manager,
    ),
    DemoAccount(
      id: 'usr_sales',
      name: 'Sales Representative',
      email: 'sales@seedapp.com',
      password: '123456',
      role: UserRole.salesRepresentative,
    ),
    DemoAccount(
      id: 'usr_field',
      name: 'Field Officer',
      email: 'field@seedapp.com',
      password: '123456',
      role: UserRole.fieldOfficer,
    ),
    DemoAccount(
      id: 'usr_dealer',
      name: 'Dealer User',
      email: 'dealer@seedapp.com',
      password: '123456',
      role: UserRole.dealer,
    ),
  ];

  static DemoAccount? findByEmail(String email) {
    final normalized = email.trim().toLowerCase();
    for (final account in all) {
      if (account.email == normalized) return account;
    }
    return null;
  }
}

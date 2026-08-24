// Exercises demo login for all 5 roles, rejection of bad credentials,
// session persistence/clearing, and the role -> permission mapping.

import 'package:flutter_test/flutter_test.dart';
import 'package:seed/core/errors/failures.dart';
import 'package:seed/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:seed/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:seed/features/auth/domain/entities/demo_account.dart';
import 'package:seed/features/auth/domain/entities/permission.dart';
import 'package:seed/features/auth/domain/entities/user_role.dart';
import 'package:seed/features/auth/domain/repositories/auth_repository.dart';

import '../../helpers/fake_auth_local_data_source.dart';

void main() {
  late AuthRepository repository;

  setUp(() {
    repository = AuthRepositoryImpl(
      remoteDataSource: DemoAuthRemoteDataSourceImpl(),
      localDataSource: FakeAuthLocalDataSource(),
    );
  });

  group('Demo login for all five roles', () {
    for (final account in DemoAccounts.all) {
      test('${account.role.displayName} (${account.email}) logs in and is cached', () async {
        final user = await repository.login(email: account.email, password: account.password);

        expect(user.role, account.role);
        expect(user.email, account.email);

        final cached = await repository.getCurrentUser();
        expect(cached, isNotNull);
        expect(cached!.role, account.role);
      });
    }
  });

  test('Wrong password is rejected with UnauthorizedFailure', () async {
    expect(
      () => repository.login(email: DemoAccounts.all.first.email, password: 'wrong-password'),
      throwsA(isA<UnauthorizedFailure>()),
    );
  });

  test('Unknown email is rejected with UnauthorizedFailure', () async {
    expect(
      () => repository.login(email: 'nobody@seedapp.com', password: '123456'),
      throwsA(isA<UnauthorizedFailure>()),
    );
  });

  test('Logout clears the cached session', () async {
    final account = DemoAccounts.all.first;
    await repository.login(email: account.email, password: account.password);
    expect(await repository.getCurrentUser(), isNotNull);

    await repository.logout();
    expect(await repository.getCurrentUser(), isNull);
  });

  group('Role permissions', () {
    test('Admin has every permission', () {
      for (final permission in Permission.values) {
        expect(UserRole.admin.hasPermission(permission), isTrue);
      }
    });

    test('Manager has full operational access but not user management', () {
      expect(UserRole.manager.hasPermission(Permission.manageUsers), isFalse);
      expect(UserRole.manager.hasPermission(Permission.manageDealers), isTrue);
      expect(UserRole.manager.hasPermission(Permission.manageFarmers), isTrue);
      expect(UserRole.manager.hasPermission(Permission.viewReports), isTrue);
    });

    test('Sales Representative can manage dealers/orders but not farmers/visits', () {
      expect(UserRole.salesRepresentative.hasPermission(Permission.manageDealers), isTrue);
      expect(UserRole.salesRepresentative.hasPermission(Permission.manageOrders), isTrue);
      expect(UserRole.salesRepresentative.hasPermission(Permission.manageFarmers), isFalse);
      expect(UserRole.salesRepresentative.hasPermission(Permission.manageVisits), isFalse);
    });

    test('Field Officer can manage farmers/visits/collections but not orders', () {
      expect(UserRole.fieldOfficer.hasPermission(Permission.manageFarmers), isTrue);
      expect(UserRole.fieldOfficer.hasPermission(Permission.manageVisits), isTrue);
      expect(UserRole.fieldOfficer.hasPermission(Permission.manageCollections), isTrue);
      expect(UserRole.fieldOfficer.hasPermission(Permission.viewOrders), isFalse);
      expect(UserRole.fieldOfficer.hasPermission(Permission.manageDealers), isFalse);
    });

    test('Dealer is restricted to viewing orders and their own profile', () {
      expect(UserRole.dealer.hasPermission(Permission.viewOrders), isTrue);
      expect(UserRole.dealer.hasPermission(Permission.manageOwnProfile), isTrue);
      expect(UserRole.dealer.hasPermission(Permission.manageOrders), isFalse);
      expect(UserRole.dealer.hasPermission(Permission.manageDealers), isFalse);
      expect(UserRole.dealer.hasPermission(Permission.manageFarmers), isFalse);
    });
  });
}

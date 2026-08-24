// Basic smoke test verifying the app boots and renders its initial route.

import 'package:flutter_test/flutter_test.dart';

import 'package:seed/main.dart';

void main() {
  testWidgets('App builds and shows the initial route', (WidgetTester tester) async {
    await tester.pumpWidget(const SeedApp());
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
  });
}

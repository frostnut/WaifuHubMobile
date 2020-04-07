// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Navigation bar routing tests', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SampleApp());

    // Tap the explore icon
    await tester.tap(find.byIcon(Icons.explore));
    await tester.pump();

    // Verify that we are at explore page
    expect(find.text('Explore Screen'), findsOneWidget);

    // Tap the home icon
    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();

    // Verify that we are at homepage
    expect(find.text('Home Screen'), findsOneWidget);

    // Tap the account icon
    await tester.tap(find.byIcon(Icons.account_box));
    await tester.pump();

    // Verify that we are at account page
    expect(find.text('Account Screen'), findsOneWidget);
  });
}

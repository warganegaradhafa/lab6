import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/factorydashboard.dart';

void main() {
  testWidgets(
      'ActivationScreen to OTPVerificationScreen to FactoryDashboardScreen navigation',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the ActivationScreen is shown
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Get Activation Code'), findsOneWidget);

    // Enter a phone number in the text field
    await tester.enterText(find.byType(TextField), '123456789');
    expect(find.text('123456789'), findsOneWidget);

    // Tap the 'Get Activation Code' button and trigger navigation
    await tester.tap(find.text('Get Activation Code'));
    await tester.pumpAndSettle();

    // Verify the OTPVerificationScreen is shown
    expect(find.text('Enter the activation code you received via SMS'),
        findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Activate'), findsOneWidget);

    // Enter an OTP code in the text field
    await tester.enterText(find.byType(TextField), '123456');
    expect(find.text('123456'), findsOneWidget);

    // Tap the 'Activate' button and trigger navigation
    await tester.tap(find.text('Activate'));
    await tester.pumpAndSettle();

    // Verify the FactoryDashboardScreen is shown
    expect(find.text('Factory 2'), findsOneWidget);
    expect(find.text('Sensor Readings'), findsOneWidget);
    expect(find.text('Steam Pressure'), findsOneWidget);
  });
}

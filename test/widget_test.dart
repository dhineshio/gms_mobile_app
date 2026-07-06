// Basic smoke test: the app boots to the splash screen, then auto-navigates
// to onboarding after the splash delay.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gms_mobile_app/core/services/local_storage_service.dart';
import 'package:gms_mobile_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:gms_mobile_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:gms_mobile_app/main.dart';

void main() {
  testWidgets('App boots to splash, then onboarding',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);

    // Splash navigates to onboarding after 2 seconds.
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}

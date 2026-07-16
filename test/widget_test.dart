// Smoke tests: the app boots to the splash screen, then auto-navigates to
// onboarding on first launch, or straight to login once onboarding is done.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gms_mobile_app/core/di/injection_container.dart';
import 'package:gms_mobile_app/core/router/app_router.dart';
import 'package:gms_mobile_app/core/router/route_names.dart';
import 'package:gms_mobile_app/core/services/local_storage_service.dart';
import 'package:gms_mobile_app/features/auth/presentation/pages/login_screen.dart';
import 'package:gms_mobile_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:gms_mobile_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:gms_mobile_app/main.dart';

void main() {
  setUpAll(() async {
    // The login screen resolves its bloc from GetIt.
    await initializeDependencies();
  });

  testWidgets('First launch: splash → onboarding',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);

    // Splash navigates after 2 seconds.
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });

  testWidgets('Onboarding already seen: splash → login',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'gms_onboarding_done': true});
    await LocalStorageService.init();

    await tester.pumpWidget(const MyApp());
    // The router is a static singleton, so reset it to splash — the previous
    // test left it on another route.
    AppRouter.router.go(RouteNames.splash);
    await tester.pumpAndSettle();
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(OnboardingScreen), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

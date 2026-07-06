import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/router/route_names.dart';

/// Brand splash shown right after the native splash. Same green background so
/// the hand-off from the native splash is seamless.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    // Release the native splash only after this screen's first frame is on
    // screen, so the two splashes swap without a flash or overlap.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
    // TODO: replace with auth/session check → login or home.
    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(RouteNames.onboarding);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // Scales with screen width, clamped so it never looks tiny on
          // compact phones or oversized on tablets (see docs/asset_sizes.md).
          width: 40.w.clamp(120.0, 220.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.sp),
            child: Image.asset(AppImages.logo),
          ),
        ),
      ),
    );
  }
}

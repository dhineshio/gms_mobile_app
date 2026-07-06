import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../widgets/onboarding_feature_item.dart';

/// Single-page onboarding: logo, headline, three feature highlights and a
/// "Get Started" call to action.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.sp),
                child: Image.asset(
                  AppImages.logo,
                  width: 25.w.clamp(120.0, 240.0),
                ),
              ),
              SizedBox(height: 3.5.h),
              Text(
                AppStrings.onboardingHeadline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                AppStrings.onboardingSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.45,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              const OnboardingFeatureItem(
                icon: LucideIcons.shieldCheck,
                title: AppStrings.onboardingFeature1Title,
                description: AppStrings.onboardingFeature1Desc,
              ),
              SizedBox(height: 3.h),
              const OnboardingFeatureItem(
                icon: LucideIcons.zap,
                title: AppStrings.onboardingFeature2Title,
                description: AppStrings.onboardingFeature2Desc,
              ),
              SizedBox(height: 3.h),
              const OnboardingFeatureItem(
                icon: LucideIcons.users,
                title: AppStrings.onboardingFeature3Title,
                description: AppStrings.onboardingFeature3Desc,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(7.w, 0, 7.w, 7.h),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: AppColors.white,
          ),
          onPressed: () {
            // TODO: navigate to login once the auth feature exists
            // (context.go(RouteNames.login)).
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.getStarted,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(LucideIcons.arrowRight, size: 19.sp),
            ],
          ),
        ),
      ),
    );
  }
}

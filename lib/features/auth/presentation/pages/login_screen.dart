import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/theme_toggle_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/otp_style_input.dart';

/// Login screen: member login with a 10-character ID by default, or
/// username/password when "Login as Admin" is switched on.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  bool _isAdmin = false;
  bool _obscurePassword = true;

  final _memberIdController = TextEditingController();
  final _adminMemberIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _memberIdController.dispose();
    _adminMemberIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnack(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  void _submit() {
    if (_isAdmin) {
      final memberId = _adminMemberIdController.text.trim();
      final password = _passwordController.text;
      if (memberId.isEmpty || password.isEmpty) {
        _showSnack('Enter your Member ID and password',
            color: AppColors.error);
        return;
      }
      context
          .read<AuthBloc>()
          .add(AdminLoginEvent(memberId: memberId, password: password));
    } else {
      final memberId = _memberIdController.text.trim();
      if (memberId.length != 10) {
        _showSnack('Member ID must be 10 characters', color: AppColors.error);
        return;
      }
      context.read<AuthBloc>().add(MemberLoginEvent(memberId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.error != null) {
              _showSnack(state.error!, color: AppColors.error);
            } else if (state.isLoggedIn) {
              final user = state.user!;
              _showSnack(
                'Welcome ${user.name ?? user.memberId}!',
                color: AppColors.success,
              );
              // TODO: navigate to home once it exists
              // (context.go(RouteNames.home)).
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),

                  // ===== Header: logo + title | admin switch | theme toggle =====
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          AppImages.logo,
                          width: 12.w.clamp(44.0, 60.0),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'GMS',
                        style: TextStyle(
                          fontSize: 18.5.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        AppStrings.loginAsAdmin,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _isAdmin,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) =>
                              setState(() => _isAdmin = value),
                        ),
                      ),
                      const ThemeToggleButton(),
                    ],
                  ),

                  SizedBox(height: 5.h),
                  Text(
                    AppStrings.login,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  Text(
                    AppStrings.loginSubtitle,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 3.5.h),

                  // ===== Member: 10-character ID | Admin: member ID + password =====
                  if (!_isAdmin) ...[
                    Text(
                      AppStrings.memberIdLabel,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    Text(
                      AppStrings.memberIdHint,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 1.8.h),
                    OtpStyleInput(controller: _memberIdController),
                  ] else ...[
                    Text(
                      AppStrings.memberIdLabel,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextField(
                      controller: _adminMemberIdController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: AppStrings.adminMemberIdHint,
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    Text(
                      AppStrings.passwordLabel,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: AppStrings.passwordHint,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          icon: Icon(
                            _obscurePassword
                                ? LucideIcons.eyeOff
                                : LucideIcons.eye,
                            size: 17.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 4.h),
                  ElevatedButton(
                    onPressed: state.isLoading ? null : _submit,
                    child: state.isLoading
                        ? SizedBox(
                            width: 20.sp,
                            height: 20.sp,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            AppStrings.login,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

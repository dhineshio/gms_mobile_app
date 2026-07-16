import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/admin_login_usecase.dart';
import '../../domain/usecases/member_login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final MemberLoginUseCase memberLoginUseCase;
  final AdminLoginUseCase adminLoginUseCase;

  AuthBloc({
    required this.memberLoginUseCase,
    required this.adminLoginUseCase,
  }) : super(const AuthState()) {
    on<MemberLoginEvent>(_onMemberLogin);
    on<AdminLoginEvent>(_onAdminLogin);
  }

  Future<void> _onMemberLogin(
    MemberLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await memberLoginUseCase(event.memberId);
    _emitResult(result, emit);
  }

  Future<void> _onAdminLogin(
    AdminLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await adminLoginUseCase(
      AdminLoginParams(memberId: event.memberId, password: event.password),
    );
    _emitResult(result, emit);
  }

  void _emitResult(
    dynamic result,
    Emitter<AuthState> emit,
  ) {
    result.fold(
      (Failure failure) => emit(
        state.copyWith(isLoading: false, error: failure.message),
      ),
      (UserEntity user) => emit(
        state.copyWith(isLoading: false, user: user, clearError: true),
      ),
    );
  }
}

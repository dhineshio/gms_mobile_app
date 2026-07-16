import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final UserEntity? user;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.error});

  bool get isLoggedIn => user != null;

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? error,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [isLoading, user, error];
}

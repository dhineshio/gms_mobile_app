import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class MemberLoginEvent extends AuthEvent {
  final String memberId;
  const MemberLoginEvent(this.memberId);

  @override
  List<Object?> get props => [memberId];
}

class AdminLoginEvent extends AuthEvent {
  final String memberId;
  final String password;
  const AdminLoginEvent({required this.memberId, required this.password});

  @override
  List<Object?> get props => [memberId, password];
}

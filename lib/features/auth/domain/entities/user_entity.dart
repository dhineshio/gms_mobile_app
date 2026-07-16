import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String memberId;
  final String? name;
  final String phoneNumber;
  final String userType;
  final String? profilePic;

  const UserEntity({
    required this.id,
    required this.memberId,
    required this.phoneNumber,
    required this.userType,
    this.name,
    this.profilePic,
  });

  bool get isAdmin => userType == 'ADMIN' || userType == 'SUPER_ADMIN';

  @override
  List<Object?> get props =>
      [id, memberId, name, phoneNumber, userType, profilePic];
}

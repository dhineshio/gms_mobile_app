class UserModel {
  final int id;
  final String memberId;
  final String? name;
  final String phoneNumber;
  final String userType;
  final String? profilePic;

  UserModel({
    required this.id,
    required this.memberId,
    required this.phoneNumber,
    required this.userType,
    this.name,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: (json['id'] as num?)?.toInt() ?? 0,
        memberId: json['member_id']?.toString() ?? '',
        name: json['name']?.toString(),
        phoneNumber: json['phone_number']?.toString() ?? '',
        userType: json['user_type']?.toString() ?? 'USER',
        profilePic: json['profile_pic']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'member_id': memberId,
        'name': name,
        'phone_number': phoneNumber,
        'user_type': userType,
        'profile_pic': profilePic,
      };
}

/// Payload of a successful login: JWT pair + the logged-in user.
class AuthResultModel {
  final String access;
  final String refresh;
  final UserModel user;

  AuthResultModel({
    required this.access,
    required this.refresh,
    required this.user,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      AuthResultModel(
        access: json['access']?.toString() ?? '',
        refresh: json['refresh']?.toString() ?? '',
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      );
}

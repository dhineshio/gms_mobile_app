import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AdminLoginParams {
  final String memberId;
  final String password;
  const AdminLoginParams({required this.memberId, required this.password});
}

class AdminLoginUseCase {
  final AuthRepository repository;
  AdminLoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(AdminLoginParams params) {
    return repository.adminLogin(params.memberId, params.password);
  }
}

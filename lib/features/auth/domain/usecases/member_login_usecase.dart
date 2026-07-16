import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class MemberLoginUseCase {
  final AuthRepository repository;
  MemberLoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String memberId) {
    return repository.memberLogin(memberId);
  }
}

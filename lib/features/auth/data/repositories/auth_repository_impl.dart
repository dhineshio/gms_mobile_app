import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> memberLogin(String memberId) {
    return _login(() => dataSource.memberLogin(memberId));
  }

  @override
  Future<Either<Failure, UserEntity>> adminLogin(
    String memberId,
    String password,
  ) {
    return _login(() => dataSource.adminLogin(memberId, password));
  }

  Future<Either<Failure, UserEntity>> _login(
    Future<AuthResultModel> Function() request,
  ) async {
    try {
      final result = await request();

      // Persist the session so the interceptor can attach the token.
      await LocalStorageService.setToken(result.access);
      await LocalStorageService.setRefreshToken(result.refresh);
      await LocalStorageService.saveUserJson(jsonEncode(result.user.toJson()));

      final u = result.user;
      return Right(UserEntity(
        id: u.id,
        memberId: u.memberId,
        name: u.name,
        phoneNumber: u.phoneNumber,
        userType: u.userType,
        profilePic: u.profilePic,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on TimeoutException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}

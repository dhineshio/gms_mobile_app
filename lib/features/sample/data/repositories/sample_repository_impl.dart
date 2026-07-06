import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/entities/sample_entity.dart';
import '../../domain/repositories/sample_repository.dart';
import '../datasources/sample_datasource.dart';

class SampleRepositoryImpl implements SampleRepository {
  final SampleRemoteDataSource dataSource;
  SampleRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<SampleEntity>>> getSamples({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final models = await dataSource.getSamples(page: page, limit: limit);
      final entities =
          models.map((m) => SampleEntity(id: m.id, title: m.title)).toList();
      return Right(entities);
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

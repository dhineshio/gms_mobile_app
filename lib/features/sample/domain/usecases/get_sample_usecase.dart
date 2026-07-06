import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sample_entity.dart';
import '../repositories/sample_repository.dart';

class GetSampleParams {
  final int page;
  final int limit;
  const GetSampleParams({this.page = 1, this.limit = 10});
}

class GetSampleUseCase {
  final SampleRepository repository;
  GetSampleUseCase(this.repository);

  Future<Either<Failure, List<SampleEntity>>> call(GetSampleParams params) {
    return repository.getSamples(page: params.page, limit: params.limit);
  }
}

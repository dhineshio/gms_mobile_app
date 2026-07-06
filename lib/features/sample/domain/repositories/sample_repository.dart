import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sample_entity.dart';

abstract class SampleRepository {
  Future<Either<Failure, List<SampleEntity>>> getSamples({int page, int limit});
}

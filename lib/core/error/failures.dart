import 'package:equatable/equatable.dart';

/// Domain-side failures. Repositories convert data-layer exceptions into these
/// so no exception ever leaks into a Bloc.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

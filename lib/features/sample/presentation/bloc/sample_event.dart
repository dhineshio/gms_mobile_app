import 'package:equatable/equatable.dart';

abstract class SampleEvent extends Equatable {
  const SampleEvent();
  @override
  List<Object?> get props => [];
}

class LoadSamplesEvent extends SampleEvent {
  final int page;
  final int limit;
  const LoadSamplesEvent({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}

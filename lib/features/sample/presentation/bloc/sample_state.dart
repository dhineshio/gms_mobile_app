import 'package:equatable/equatable.dart';

import '../../domain/entities/sample_entity.dart';

class SampleState extends Equatable {
  final bool isLoading;
  final List<SampleEntity> samples;
  final String? error;

  const SampleState({
    this.isLoading = false,
    this.samples = const [],
    this.error,
  });

  SampleState copyWith({
    bool? isLoading,
    List<SampleEntity>? samples,
    String? error,
    bool clearError = false,
  }) {
    return SampleState(
      isLoading: isLoading ?? this.isLoading,
      samples: samples ?? this.samples,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [isLoading, samples, error];
}

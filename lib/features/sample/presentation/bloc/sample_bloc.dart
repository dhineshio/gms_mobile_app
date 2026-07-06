import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_sample_usecase.dart';
import 'sample_event.dart';
import 'sample_state.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  final GetSampleUseCase getSampleUseCase;

  SampleBloc({required this.getSampleUseCase}) : super(const SampleState()) {
    on<LoadSamplesEvent>(_onLoadSamples);
  }

  Future<void> _onLoadSamples(
    LoadSamplesEvent event,
    Emitter<SampleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getSampleUseCase(
      GetSampleParams(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: _mapFailureToMessage(failure),
      )),
      (samples) => emit(state.copyWith(
        isLoading: false,
        samples: samples,
        clearError: true,
      )),
    );
  }

  String _mapFailureToMessage(Failure failure) => failure.message;
}

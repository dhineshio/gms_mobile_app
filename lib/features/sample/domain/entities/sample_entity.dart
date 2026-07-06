import 'package:equatable/equatable.dart';

class SampleEntity extends Equatable {
  final String id;
  final String title;

  const SampleEntity({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}

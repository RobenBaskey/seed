import 'package:equatable/equatable.dart';

/// Base contract for domain-layer use cases. `ReturnType` is the success
/// return type, `Params` is the input. Use [NoParams] when a use case
/// takes no arguments.
abstract class UseCase<ReturnType, Params> {
  Future<ReturnType> call(Params params);
}

/// Marker input for use cases that don't need parameters.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}

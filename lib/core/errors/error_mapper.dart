import 'exceptions.dart';
import 'failures.dart';

/// Maps data-layer exceptions to domain-layer [Failure]s. Repository
/// implementations catch exceptions thrown by their data sources and use
/// this so the domain/presentation layers only ever see [Failure]s.
Failure mapExceptionToFailure(Object error) {
  if (error is ServerException) return ServerFailure(error.message);
  if (error is NetworkException) return NetworkFailure(error.message);
  if (error is TimeoutException) return TimeoutFailure(error.message);
  if (error is CacheException) return CacheFailure(error.message);
  if (error is UnauthorizedException) return UnauthorizedFailure(error.message);
  return UnknownFailure(error.toString());
}

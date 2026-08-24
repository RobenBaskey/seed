/// Low-level exceptions thrown by the data layer (e.g. Dio client,
/// local storage). These get caught in repositories and mapped to
/// [Failure]s for the domain/presentation layers to consume.
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({this.message = 'Server error occurred', this.statusCode});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = 'No internet connection'});
}

class TimeoutException implements Exception {
  final String message;

  const TimeoutException({this.message = 'Request timed out'});
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache error occurred'});
}

class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException({this.message = 'Unauthorized'});
}

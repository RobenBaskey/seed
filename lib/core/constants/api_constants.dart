/// Network-related constants for the future API integration.
/// No real endpoints are wired up yet — this only defines the shape.
class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://api.example.com';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String applicationJson = 'application/json';
}

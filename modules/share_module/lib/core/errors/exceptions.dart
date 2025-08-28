/// Exception thrown when a server returns an error response.
class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Server error occurred'});
}

/// Exception thrown when there is no internet connection.
class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'No internet connection'});
}

/// Exception thrown when a local cache read/write fails.
class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Cache error occurred'});
}

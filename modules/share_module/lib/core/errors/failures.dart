abstract class Failure {
  final String message;

  const Failure({required this.message});
}

/// General server-side failure.
class ServerFailure extends Failure {
  String message = 'Something went wrong on the server';

  ServerFailure({required super.message});
}

/// No internet connection.
class NetworkFailure extends Failure {
  String message = 'No internet connection';

  NetworkFailure({required super.message});
}

/// Local cache/database failure.
class CacheFailure extends Failure {
  String message = 'Error accessing local data';

  CacheFailure({required super.message});
}

/// Validation failure
class ValidationFailure extends Failure {
  final String message = 'Invalid input';

  ValidationFailure({required super.message});
}

/// unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}

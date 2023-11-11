class ServerException implements Exception {
  final String message;
  final int statusCode;

  const ServerException(this.message, [this.statusCode = 404]);
}

///local database exception
class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException(message: $message)';
}

/// default exception
class FetchDataException extends ServerException {
  const FetchDataException(super.message, [super.statusCode = 666]);
}

///Unsupported Media Type
class DataFormatException extends ServerException {
  const DataFormatException(super.message, [super.statusCode = 415]);
}

/// The server cannot or will not process the request due to an apparent
/// ///client error (e.g., malformed request syntax, size too large,
/// invalid request message framing, or deceptive request routing
class BadRequestException extends ServerException {
  const BadRequestException(super.message, [super.statusCode = 400]);
}

class UnauthorisedException extends ServerException {
  const UnauthorisedException(super.message, [super.statusCode = 401]);
}

class InternalServerException extends ServerException {
  const InternalServerException(super.message, [super.statusCode = 500]);
}

class NetworkException extends ServerException {
  const NetworkException(super.message, [super.statusCode = 511]);
}

class UnknownException extends ServerException {
  const UnknownException(super.message, [super.statusCode = 500]);
}

class ObjectToModelException extends ServerException {
  const ObjectToModelException(super.message, [super.statusCode = 600]);
}

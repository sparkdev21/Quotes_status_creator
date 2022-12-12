abstract class ApiExceptionMapper {
  static String toErrorMessage(Object error) {
    if (error is ApiException) {
      if (error is ConnectionException) {
        return Strings.connectionError;
      } else if (error is ClientErrorException) {
        return Strings.clientError;
      } else if (error is ServerErrorException) {
        return Strings.serverError;
      } else if (error is EmptyResultException) {
        return Strings.emptyResultError;
      } else {
        return Strings.unknownError;
      }
    } else {
      return Strings.unknownError;
    }
  }
}

abstract class ApiException implements Exception {}

class EmptyResultException extends ApiException {}

class ConnectionException extends ApiException {}

class ServerErrorException extends ApiException {}

class ClientErrorException extends ApiException {}

class UnknownException extends ApiException {}

class Strings {
  static const connectionError = "No internet connection";
  static const clientError = "Resource not found";
  static const serverError = "Internal server error";
  static const unknownError = "Unknown error ";
  static const emptyResultError = "Request body was empty";
}

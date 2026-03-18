class AppExceptions implements Exception {
  final String? message;
  final String? prefix;

  AppExceptions([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix$message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
    : super(message, 'No internet connection');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request timed out');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
    : super(message, 'Error during communication');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? message])
    : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

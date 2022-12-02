
class AppException implements Exception{
  final String? _prefix;
  final String? _message;
  AppException(this._prefix,this._message);

  @override
  String toString() {
    return ' $_prefix, $_message';
  }
}
//check problem with request data from api
class FetchDataException extends AppException{
  FetchDataException(String? message): super(message,'error during communication');
}


class BadRequestException extends AppException{
  BadRequestException(String? message) : super(message,'Bad Request');
}

class UnAuthorizedException extends AppException{
  UnAuthorizedException(String? message) : super(message,'UnAuthorized Request');
}
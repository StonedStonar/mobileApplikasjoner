///Represents a exception that is thrown when a game could not be removed.
class CouldNotRemoveGameException implements Exception{

  ///Makes an instance of the exception.
  ///[_message] the message
  CouldNotRemoveGameException(this._message);

  final String _message;

  ///Gets the message of the exception.
  ///Returns the message.
  String getMessage(){
    return _message;
  }
}
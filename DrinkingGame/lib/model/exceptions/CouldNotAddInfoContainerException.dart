///Represents a exception that is thrown when a info container could not be added.
class CouldNotAddInfoContainerException implements Exception{

  ///Makes an instance of the exception.
  ///[_message] the message
  CouldNotAddInfoContainerException(this._message);

  final String _message;

  ///Gets the message of the exception.
  ///Returns the message.
  String getMessage(){
    return _message;
  }
}
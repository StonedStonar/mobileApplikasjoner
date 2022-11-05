///Represents a exception that is thrown when a question could not be added.
class CouldNotAddQuestionException implements Exception{

  ///Makes an instance of the exception.
  ///[_message] the message
  CouldNotAddQuestionException(this._message);

  final String _message;

  ///Gets the message of the exception.
  ///Returns the message.
  String getMessage(){
    return _message;
  }
}
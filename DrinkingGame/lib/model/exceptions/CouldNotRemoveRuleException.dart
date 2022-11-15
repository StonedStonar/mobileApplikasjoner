///Represents a exception that is thrown when a rule could not be removed.
class CouldNotRemoveRuleException implements Exception{

  ///Makes an instance of the exception.
  ///[_message] the message
  CouldNotRemoveRuleException(this._message);

  final String _message;

  ///Gets the message of the exception.
  ///Returns the message.
  String getMessage(){
    return _message;
  }
}
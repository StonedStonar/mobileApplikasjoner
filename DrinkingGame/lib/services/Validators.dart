
/// For mixin use
abstract class StringValidator {
  bool isValid(String value);
}

///Validates a username
///The username is valid if it only contains alphanumeric characters
///with a minimum length of 3, and max length of 20
class UsernameValidator implements StringValidator {
  final usernameRegexp = RegExp(r"^(?=[a-zA-Z0-9._]{3,20}$)(?!.*[_.]{2})[^_.].*[^_.]$");

  @override
  bool isValid(String value) {
    return usernameRegexp.hasMatch(value);
  }
}

///Validates an email
class EmailValidator implements StringValidator {
  final emailRegexp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+$");

  @override
  bool isValid(String value) {
    return emailRegexp.hasMatch(value);
  }
}

///Validates a password
///The password must contain: One uppercase letter, one lower case letter,
///one number, a minimum of totally 8 letters, and maximum of 20.
///TODO: Possibly add lighten up criteria to not have capital letter and numbers
class PasswordValidator implements StringValidator {
  final passwordRegexp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,20}$");

  @override
  bool isValid(String value) {
    return passwordRegexp.hasMatch(value);
  }
}

/// For mixin use
class UsernamePasswordAndEmailValidators {
  final StringValidator usernameValidator = UsernameValidator();
  final StringValidator emailValidator = EmailValidator();
  final StringValidator passwordValidator = PasswordValidator();
}

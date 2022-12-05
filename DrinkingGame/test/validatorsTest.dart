import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter_test/flutter_test.dart';


///Validates a username
///The username is valid if it only contains characters,
///with a minimum length of 3, and max length of 20
///
void main() {
  group("UsernameValidator tests", () {
  test("If Username works with valid input.", () {
    final validator = UsernameValidator();
    expect(validator.isValid("Kenth"), true);
  });
  //Negative tests for username.
  test("Test Username is null", () {
    final validator = UsernameValidator();
    expect(validator.isValid(""), false);
  });
  test("If Username fails with spacing", () {
    final validator = UsernameValidator();
    expect(validator.isValid("Kevin Even"), false);
  });
  test("Test Username with numbers", () {
    final validator = UsernameValidator();
    expect(validator.isValid("007"), false);
  });
  test("Test Username with less than 3 characters", () {
    final validator = UsernameValidator();
    expect(validator.isValid("No"), false);
  });
  test("Test Username with more than 20 characters", () {
    final validator = UsernameValidator();
    expect(validator.isValid("KennethKennethKennethKenneth"), false);
  });
  });

  ///Test the validation of email.
  ///Should be of standard email format.
  ///
  group("EmailValidator tests", () {
    test("If EmailValidator works with valid input", () {
      final validator = EmailValidator();
      expect(validator.isValid("Test@test.com"), true);
    });
    //Negative tests for email validator
    test("Test an email without characters before @", () {
      final validator = EmailValidator();
      expect(validator.isValid("@test.com"), false);
    });
    test("Test an email without characters after @", () {
      final validator = EmailValidator();
      expect(validator.isValid("test@"), false);
    });
    test("Test empty email", () {
      final validator = EmailValidator();
      expect(validator.isValid(""), false);
    });
    test("Test without @", () {
      final validator = EmailValidator();
      expect(validator.isValid("Testing.com"), false);
    });

    ///Validates a password
    ///The password must contain: One uppercase letter, one lower case letter,
    ///one number, a minimum of totally 4 letters, and maximum of 20.
    ///
    group("PasswordValidator tests", () {
      test("If PasswordValidator works with valid input", () {
        final validator = PasswordValidator();
        expect(validator.isValid("ChuckNorris123"), true);
      });
      //Negative tests for PasswordValidator
      test("Test if password works without numbers in password", () {
        final validator = PasswordValidator();
        expect(validator.isValid("ChuckNorris"), false);
      });
      test("Test if password works without uppercase characters in password", () {
        final validator = PasswordValidator();
        expect(validator.isValid("chuck123"), false);
      });
      test("Test password with a length of less than 4", () {
        final validator = PasswordValidator();
        expect(validator.isValid("Ch1"), false);
      });
      test("Test password with a length of more than 20", () {
        final validator = PasswordValidator();
        expect(validator.isValid("ChuckNorrisNorris123123123"), false);
      });
    });





  });
}
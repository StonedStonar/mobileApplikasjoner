import 'package:drinkinggame/services/Validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("non empty string", () {
    final validator = UsernameValidator();
    expect(validator.isValid("test"), true);
  });

  test("empty string", () {
    final validator = UsernameValidator();
    expect(validator.isValid(""), false);
  });

}
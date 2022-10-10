// This file contains Flutter unit tests.

import 'package:flexicharge/models/password_set.dart';
import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //ARRANGE
  UserInputValidator userInputValidator = new UserInputValidator();

  group('Test client-side password validataion', () {
    const inputsToExpected = <String, bool>{
      'pegu20ju@@': false,
      'Test.1234': true,
      'Test1234': false,
      'Test.12': false,
      '': false,
      'abcdefghijklmno': false,
      '_123Test.se': true,
    };

    inputsToExpected.forEach((input, expected) {
      test('$input -> $expected', () {
        //ACT
        final bool result = userInputValidator.passwordIsValid(input);

        //ASSERT
        expect(result, expected);
      });
    });
  });

  group('Test client-side email validation', () {
    const inputsToExpected = <String, bool>{
      'pegu20ji@student.ju.se': true,
      'liti20dt@student.ju.se': true,
      'pegu20ji@@student.ju.se': false,
      'pegu20ji': false,
      'pegu20ji@': false,
      'test@test.se': true,
      'test.testsson@edu.jonkoping.se': true,
    };

    inputsToExpected.forEach((input, expected) {
      test('$input -> $expected', () {
        //ACT
        final bool result = userInputValidator.emailIsValid(input);

        //ASSERT
        expect(result, expected);
      });
    });
  });

  group('Test client-side password match', () {
    final inputsToExpected = <PasswordPair, bool>{
      PasswordPair('Test.1234', 'Test.1234'): true,
      PasswordPair('test.1234', 'Test.1234'): false,
      PasswordPair('teståäö', 'teståäö'): true,
      PasswordPair('postgres.', 'postgres'): false,
    };
    inputsToExpected.forEach((input, expected) {
      test('${input.password1} == ${input.password2} -> $expected', () {
        //ACT
        final bool result = userInputValidator.passwordsAreEqual(
            input.password1, input.password2);

        //ASSERT
        expect(result, expected);
      });
    });
  });
}

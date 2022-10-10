// This file contains a Flutter unit test.

import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test client-side password validataion', () {
    //ARRANGE
    UserInputValidator userInputValidator = new UserInputValidator();

    const inputsToExpected = <String, bool>{
      'pegu20ju@@': false,
      'Test.1234': true,
      'Test1234': false,
      'Test.12': false,
      '': false,
      'abcdefghijklmno': false,
      '_123Test.se': true
    };

    inputsToExpected.forEach((input, expected) {
      test('$input -> $expected', () {
        //ACT
        bool result = userInputValidator.passwordIsValid(input);

        //ASSERT
        expect(result, expected);
      });
    });
  });

  group('Test client-side email validation', () {
    //ARRANGE
    UserInputValidator userInputValidator = new UserInputValidator();

    const inputsToExpected = <String, bool>{
      'pegu20ji@student.ju.se': true,
      'liti20dt@student.ju.se': true,
      'pegu20ji@@student.ju.se': false,
      'pegu20ji': false,
      'pegu20ji@': false,
      'test@test.se': true,
      'test.testsson@edu.jonkoping.se': true
    };

    inputsToExpected.forEach((input, expected) {
      test('$input -> $expected', () {
        //ACT
        bool result = userInputValidator.emailIsValid(input);

        //ASSERT
        expect(result, expected);
      });
    });
  });
}

// This file contains a Flutter unit test.

import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test client side password validataion", () {
    //ARRANGE
    UserInputValidator userInputValidator = new UserInputValidator();

    const inputsToExpected = <String, bool>{
      "pegu20ju@@": false,
      "Test.1234": true,
      "Test1234": false,
      "Test.12": false,
      "": false,
      "abcdefghijklmno": false,
      "_123Test.se": true
    };

    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        //ACT
        bool result = userInputValidator.passwordIsValid(input);

        //ASSERT
        expect(result, expected);
      });
    });
  });
}

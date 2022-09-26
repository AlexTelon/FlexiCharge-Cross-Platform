# FlexiCharge-Cross-Platform
A app written in Flutter for Flexicharge by third year students from Jönköping University (2021)

## Build Status
<a href="https://github.com/knowitrickard/FlexiCharge-Cross-Platform/actions">
    <img src="https://github.com/knowitrickard/FlexiCharge-Cross-Platform/workflows/test-flexicharge-cross-platform/badge.svg" alt="Build Status">
</a>

## Setup
Make sure flutter is installed on you system. Check for errors by running `flutter doctor` in a terminal. If Flutter is not installed, follow your respective operating system install guide in the file README_FLUTTER_SETUP.md

Download the project by either cloning it or by downloading the zip-file. After extracting the project, open it up with Visual Studio Code.

### VSCode
Make sure that the extention Flutter (version: v3.27.0) is installed and enabled.

If you get prompted that some packages are missing, press download. Else, go to pubspec.yaml and and download the packages from there, or download from the terminal by entering `flutter pub get`

The app can now be started with either the command `flutter run` or by going to main.dart. If you have a connected supported Android or IOS device,  or an emulator up and running, the app should launch fine. :)

### Versions
Developed with Flutter version 

- 3.3.1, upgraded from 2.2.1 in 2022

Developed with Dart version

- 2.18.0

Supports Android versions

- minSdkVersion 26
- targetSdkVersion 32, upgraded from 30 in 2022

Supports IOS versions
- Non set

## Architecture
### Stacked Architecture
TODO
https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/

### Naming convention
- Files: snake_case
- Classes: PascalCase
- General variables: camelCase
- Private member variables: _camelCase

### Services
Used mostly when accessing the API and making requests
https://www.filledstacks.com/post/services-in-code-and-how-to-use-them-in-flutter/

### LocalData
A class that enables us to save variables into an object that we can access from anywhere. Unified place to find common variables used on several occasions across the whole app.

### Models
A way to map data to a class. Used to map json-objects from the API into usable data-classes.

# Workflow
Documentation about how certain actions are performed within the app, steps needed and in what order etc.

## Connect to charger
When a valid charger ID has been entered we want to reserve the charger during the payment process.
To enter a charger, we need the charger ID. We can get this from three different ways.
1. Scan QR code on the charger, which automatically enters the charger ID into the PIN input field.
2. Choose a charger point (green marker on the map view) and select a charger from the list. This will also automatically enter the pin into the PIN input field
3. Enter the Charger ID manually.

Then, we create a transaction session and receive a transaction object back from the API.
This transaction object contains a transactionID that we need when getting a authentication token from Klarna.
The authentication token from Klarna can then be used to update our transaction object that verifies that our transaction was successful.

In snappingsheet_viewmodel.dart, the connect function solves this.

## Klarna Payment
There exists no native implementation of Klarna within Flutter, therefore it is implemented in native Android and IOS. 
|When making a reservation for a charger, use the following personal details in Klarna|
|:--:|
|![image-20211011145831799](https://user-images.githubusercontent.com/36575668/191029596-67f4a817-e1b6-4fe6-8343-44c93b69e6a3.png)|

|These Credit Card Details should be used for Klarna|
|:--:|
|![image-20211013123905119](https://user-images.githubusercontent.com/36575668/191029537-6165d5ee-df7f-48e7-8946-7814a75b327d.png)|

# Contribution
Follow the convention and coding style explained under chapter Architecture.

# Testing
Test cases are located in the top level folder `test` and are divided into separate files for Widget tests and Unit tests. At the time of writing, only Widget tests are created since most of the code can not be tested with Unit tests easily. Integration tests is a goal to implement in the future.

## Automated testing
A GitHub actions workflow is implemented and gets triggered for each push- and merge to the main-branch. The workflow runs all tests.

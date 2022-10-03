# FlexiCharge-Cross-Platform
A app written in Flutter for Flexicharge by third year students from Jönköping University (2021)

## Test Status
<a href="https://github.com/knowitrickard/FlexiCharge-Cross-Platform/actions">
    <img src="https://github.com/knowitrickard/FlexiCharge-Cross-Platform/workflows/test-flexicharge-cross-platform/badge.svg" alt="Build Status">
</a>

## Setup
Make sure flutter is installed on you system. Check for errors by running `flutter doctor` in a terminal. If Flutter is not installed, follow your respective operating system install guide in the file README_FLUTTER_SETUP.md

Download the project by either cloning it or by downloading the zip-file. After extracting the project, open it up with Visual Studio Code.

### VS Code
Make sure that the extension Flutter (version: v3.27.0) is installed and enabled.

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

Supports iOS versions
- 15.0

# Contribution
Follow the convention and coding style explained under chapter Architecture.

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/app/setup_dialog_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  setupBottomSheetUi();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            bodyText1: TextStyle(
                // White text
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w400,
                fontFamily: "Lato",
                fontStyle: FontStyle.normal,
                fontSize: 17.0),
            bodyText2: TextStyle(
                // Black text
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: "ITCAvantGardeStd",
                fontStyle: FontStyle.normal,
                fontSize: 17.0),
          )),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}

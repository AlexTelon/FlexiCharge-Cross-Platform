// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/screens/home_page/home_view.dart';
import '../ui/screens/launch/launch_view.dart';
import '../ui/screens/login_page/login_view.dart';
import '../ui/screens/qr_scanner/qr_scanner_view.dart';
import '../ui/screens/registration_page/registration_view.dart';

class Routes {
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String registrationView = '/registration-view';
  static const String qrScannerView = '/qr-scanner-view';
  static const String launchView = '/';
  static const all = <String>{
    homeView,
    loginView,
    registrationView,
    qrScannerView,
    launchView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registrationView, page: RegistrationView),
    RouteDef(Routes.qrScannerView, page: QrScannerView),
    RouteDef(Routes.launchView, page: LaunchView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegistrationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegistrationView(),
        settings: data,
      );
    },
    QrScannerView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => QrScannerView(),
        settings: data,
      );
    },
    LaunchView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LaunchView(),
        settings: data,
      );
    },
  };
}

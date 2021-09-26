// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/screens/home_page/home_view.dart';
import '../ui/screens/login_page/login_view.dart';
import '../ui/screens/registration_page/registration_view.dart';

class Routes {
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String registrationView = '/';
  static const all = <String>{
    homeView,
    loginView,
    registrationView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registrationView, page: RegistrationView),
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
  };
}

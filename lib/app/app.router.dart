// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/screens/home_page/home_view.dart';
import '../ui/screens/qr_scanner/qr_scanner_view.dart';

class Routes {
  static const String homeView = '/';
  static const String qrScannerView = '/qr-scanner-view';
  static const all = <String>{
    homeView,
    qrScannerView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.qrScannerView, page: QrScannerView),
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
    QrScannerView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => QrScannerView(),
        settings: data,
      );
    },
  };
}

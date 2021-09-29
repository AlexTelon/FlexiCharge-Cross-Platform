// import 'package:mollie/mollie.dart';
import 'package:flexicharge/models/order_line.dart';
import 'package:http/http.dart' as http;

class KlarnaApiService {
  static const endPoint = "https://api.playground.klarna.com/";
  http.Client client = new http.Client();

  // Implement from the images, Klarna_Required in Rawa Test Clip Folder on desktop.
  String purchase_country = '';
  String purchase_currency = '';
  String locale = '';
  int order_amount = 0;
  int order_tax_amount = 0;
  List<OrderLine> order_lines = [];

  // Implement the POST Methods.
  Future<List> createOrder() async {
    return [];
  }

  Future<void> getAccessToken() async {}
}

class OrderLine {
  String image_url = '';
  String type = '';
  String reference = '';
  String name = '';
  int quantity = 0;
  int unit_price = 0;
  int tax_rate = 0;
  int total_amount = 0;
  int total_tax_amount = 0;

  OrderLine();
  OrderLine.fromOrder({
    required this.image_url,
    required this.type,
    required this.reference,
    required this.name,
    required this.quantity,
    required this.unit_price,
    required this.tax_rate,
    required this.total_amount,
    required this.total_tax_amount,
  });
}

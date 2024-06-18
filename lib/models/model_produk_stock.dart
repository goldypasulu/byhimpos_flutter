class ListProductStock {
  String product_id;
  String current_stock;
  String name;

  ListProductStock(
      {required this.product_id,
      required this.current_stock,
      required this.name});

  factory ListProductStock.fromJson(Map<String, dynamic> json) {
    return ListProductStock(
        product_id: json['product_id'],
        current_stock: json['current_stock'],
        name: json['name']);
  }
}

class CartItem {
  int id;
  String name;
  //double qty;
  double price;
  String variant;

  CartItem({
    required this.id,
    required this.name,
    //required this.qty,
    required this.price,
    required this.variant,
  });

  double get total => price;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      //qty: double.parse(json['qty']) ?? 1,
      price: double.parse(json['harga_ml']),
      variant: json['variant'],
    );
  }
}
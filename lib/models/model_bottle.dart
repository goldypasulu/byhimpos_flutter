class ListBottle {
  final int id;
  final String bottleSize;
  final String variant;
  final double hargaMl;

  ListBottle({
    required this.id,
    required this.bottleSize,
    required this.variant,
    required this.hargaMl,
  });

  factory ListBottle.fromJson(Map<String, dynamic> json) {
    return ListBottle(
      id: json['id'],
      bottleSize: json['bottle_size'],
      variant: json['variant'],
      hargaMl: json['harga_ml'].toDouble(),
    );
  }
}

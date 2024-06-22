class ListProduct {
  int id;
  dynamic name;
  String description;
  dynamic image;
  String price;
  //String stock;
  String status;
  String is_favorite;
  String branch_id;
  dynamic foto_path;

  ListProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    //required this.stock,
    required this.status,
    required this.is_favorite,
    required this.branch_id,
    required this.foto_path,
  });

  factory ListProduct.fromJson(Map<String, dynamic> json) {
    return ListProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      //stock: json['stock'],
      status: json['status'],
      is_favorite: json['is_favorite'],
      branch_id: json['branch_id'],
      foto_path: json['foto_path'],
    );
  }
}

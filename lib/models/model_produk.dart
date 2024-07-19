class ListProduct {
  int id;
  String? categoryId;
  String? name;
  String? description;
  String? image;
  String? price;
  String? stock;
  String? status;
  String? isFavorite;
  String? createdAt;
  String? updatedAt;
  String? branchId;
  String? fotoPath;

  ListProduct({
    required this.id,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.price,
    // this.stock,
    this.status,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.fotoPath,
  });

  factory ListProduct.fromJson(Map<String, dynamic> json) {
    return ListProduct(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      status: json['status'],
      isFavorite: json['is_favorite'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      branchId: json['branch_id'],
      fotoPath: json['foto_path'],
    );
  }
}

class BundleItem {
  int productId;
  String? productName;
  String? productDescription;
  String? productImage;
  int productPrice;
  int productStock;
  int bundleQuantity;
  double bundleDiscount;
  String? bottleName;
  int bottleSize;
  String? bottleType;
  int? bottleId;

  BundleItem({
    required this.productId,
    this.productName,
    this.productDescription,
    this.productImage,
    required this.productPrice,
    required this.productStock,
    required this.bundleQuantity,
    required this.bundleDiscount,
    this.bottleName,
    required this.bottleSize,
    this.bottleType,
    this.bottleId,
  });

  factory BundleItem.fromJson(Map<String, dynamic> json) {
    return BundleItem(
      productId: int.parse(json['product_id']?.toString() ?? '0'),
      productName: json['product_name'] ?? '',
      productDescription: json['product_description'] ?? '',
      productImage: json['product_image'] ?? '',
      productPrice: int.parse(json['product_price']?.toString() ?? '0'),
      productStock: int.parse(json['product_stock']?.toString() ?? '0'),
      bundleQuantity: int.parse(json['bundle_quantity']?.toString() ?? '0'),
      bundleDiscount: double.parse(json['bundle_discount']?.toString() ?? '0.0'),
      bottleName: json['bottle_name'] ?? '',
      bottleSize: int.parse(json['bottle_size']?.toString() ?? '0'),
      bottleType: json['bottle_type'] ?? '',
      bottleId: json['bottle_id'] != null ? int.parse(json['bottle_id'].toString()) : null
    );
  }
}

class Bundle {
  int id;
  String name;
  String description;
  int price;
  String? startDate;
  String? endDate;
  List<BundleItem> products;
  List<BundleItem> items;

  Bundle({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.startDate,
    this.endDate,
    required this.products,
    required this.items,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<BundleItem> productItems = productList.map((i) => BundleItem.fromJson(i)).toList();

    var itemList = json['items'] as List;
    List<BundleItem> bundleItems = itemList.map((i) => BundleItem.fromJson(i)).toList();

    return Bundle(
      id: int.parse(json['id']?.toString() ?? '0'),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: int.parse(json['price']?.toString() ?? '0'),
      startDate: json['start_date'],
      endDate: json['end_date'],
      products: productItems,
      items: bundleItems,
    );
  }
}

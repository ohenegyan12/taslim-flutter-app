class Product {
  final int id;
  final String name;
  final String sku;
  final String? category;
  final double cost;
  final double price;
  final int stock;
  final int minStock;
  final String? brand;
  final String? model;
  final String? unit;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    this.category,
    required this.cost,
    required this.price,
    this.stock = 0,
    this.minStock = 0,
    this.brand,
    this.model,
    this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      category: json['category'],
      cost: (json['cost'] ?? 0.0).toDouble(),
      price: (json['price'] ?? 0.0).toDouble(),
      stock: json['stock'] ?? 0,
      minStock: json['minStock'] ?? 0,
      brand: json['brand'],
      model: json['model'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'cost': cost,
      'price': price,
      'stock': stock,
      'minStock': minStock,
      'brand': brand,
      'model': model,
      'unit': unit,
    };
  }
}

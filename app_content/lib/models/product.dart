class Product {
  final int id;
  final String categoryId;
  final String name;
  final double price;
  final String description;
  final String image;
  final bool featured;

  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.featured,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      categoryId: (json['categoryId'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      price: (json['price'] as num).toDouble(),
      description: (json['description'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      featured: (json['featured'] ?? false) == true,
    );
  }
}

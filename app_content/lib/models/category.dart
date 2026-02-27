class Category {
  final String id;
  final String name;
  final String icon;
  final String image;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      icon: (json['icon'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
    );
  }
}
